
public protocol Content {
    associatedtype Body: Content
    var body: Body { get }
}

// MARK: - Generator

extension Content {

    func generate(indentation: Indentation) -> [Line] {

        if let builtin = self as? Builtin {
            return builtin.generate(indentation: indentation)
        }

        return body.generate(indentation: indentation)
    }
}

// MARK: - Builder

@resultBuilder
public enum ContentBuilder {

    public static func buildPartialBlock(first: some Content) -> some Content {
        first
    }

    public static func buildPartialBlock(accumulated: some Content, next: some Content) -> some Content {
        AccumulatedContent(first: accumulated, second: next)
    }

    public static func buildArray<C: Content>(_ array: [C]) -> [C] {
        array
    }

    public static func buildEither<C: Content>(first: C) -> C {
        first
    }

    public static func buildEither<C: Content>(second: C) -> C {
        second
    }

    public static func buildOptional<C: Content>(_ optional: C?) -> C? {
        optional
    }

    public static func buildFinalResult(_ component: some Content) -> some Content {
        component
    }
}
