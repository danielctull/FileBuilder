
public struct Line: Equatable {

    fileprivate let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Line: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension String {

    init(_ line: Line) {
        self = line.rawValue
    }
}

// MARK: - Modification

extension Line {

    func prefix(_ prefix: String) -> Line {
        Line(prefix + rawValue)
    }

    func suffix(_ suffix: String) -> Line {
        Line(rawValue + suffix)
    }
}

// MARK: - Content {

extension Line: Content {

    public var body: some Content {
        Builtin { _ in [self] }
    }
}
