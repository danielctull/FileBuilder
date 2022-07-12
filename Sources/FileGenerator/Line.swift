
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

// MARK: - Generate

extension Line {

    func generate(indentation: Indentation, level: Indentation.Level) -> String {
        level.prefix(for: indentation) + rawValue
    }
}
