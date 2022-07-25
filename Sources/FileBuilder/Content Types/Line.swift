
public struct Line: Equatable {
    let rawValue: String
}

extension Line {
    public static let empty = Line(rawValue: "")
}

// MARK: - Modification

extension Line {

    public func prefix(_ prefix: String) -> Line {
        Line(rawValue: prefix + rawValue)
    }

    public func suffix(_ suffix: String) -> Line {
        Line(rawValue: rawValue + suffix)
    }
}

// MARK: - Content {

extension Line: Content {

    public var body: some Content {
        BuiltinContent { _ in [self] }
    }
}
