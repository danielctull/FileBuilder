
public struct Line: Equatable {
    let rawValue: String

    init(_ string: some StringProtocol) {
        self.rawValue = String(string)
    }
}

extension Line {
    public static var empty: Line { Line("") }
}

// MARK: - Modification

extension Line {

    public func prefix(_ prefix: String) -> Line {
        Line(prefix + rawValue)
    }

    public func suffix(_ suffix: String) -> Line {
        Line(rawValue + suffix)
    }
}

// MARK: - Content {

extension Line: Text {

    public var text: some Text {
        BuiltinText { _ in [self] }
    }
}
