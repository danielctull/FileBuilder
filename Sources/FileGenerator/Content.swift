
public protocol Content {
    associatedtype Body: Content
    var body: Body { get }
}

// MARK: - Builtin Content

extension Content where Body == Never {
    public var body: Never { fatalError("This should never be called.") }
}

extension Never: Content {
    public var body: Never { fatalError() }
}

// MARK: - Generator

extension Content {

    func generate(indentation: Indentation, level: Indentation.Level) -> String {
        switch self {
        case let generator as any Generator:
            return generator.generate(indentation: indentation, level: level)
        default:
            fatalError("Unsupported value \(self)")
        }
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
