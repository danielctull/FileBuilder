
public struct Line: Equatable {

    let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Line: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.init(value)
    }
}

// MARK: - Content {

extension Line: Content {
    public typealias Body = Never
}

// MARK: - Generator

extension Line: Generator {

    func generate(indentation: Indentation, level: Indentation.Level) -> String {
        level.prefix(for: indentation) + rawValue
    }
}
