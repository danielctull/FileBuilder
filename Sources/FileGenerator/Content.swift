
public protocol Content {
    associatedtype Body: Content
    var body: Body { get }
}

// MARK: - Generator

extension Content {

    func generate(indentation: Indentation, level: Indentation.Level) -> String {

        if let builtin = self as? Builtin {
            return builtin.generate(indentation: indentation, level: level)
        }

        return body.generate(indentation: indentation, level: level)
    }
}

// MARK: - Builder

@resultBuilder
public enum ContentBuilder {

    public static func buildPartialBlock(first: some Content) -> some Content {
        first
    }

    public static func buildPartialBlock(accumulated: some Content, next: some Content) -> some Content {
        AccumulatedContent(a: accumulated, b: next)
    }

    public static func buildFinalResult(_ component: some Content) -> some Content {
        component
    }
}
