
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

    public var body: some Content {

        Generator { indentation, level in
            level.prefix(for: indentation) + rawValue
        }
    }
}
