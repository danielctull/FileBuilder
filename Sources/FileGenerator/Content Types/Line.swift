
public struct Line: Equatable {
    let rawValue: String
}

extension Line {
    public static let empty = Line(rawValue: "")
}

// MARK: - Modification

extension Line {

    func prefix(_ prefix: String) -> Line {
        Line(rawValue: prefix + rawValue)
    }

    func suffix(_ suffix: String) -> Line {
        Line(rawValue: rawValue + suffix)
    }
}

// MARK: - Content {

extension Line: Content {

    public var body: some Content {
        Builtin { _ in [self] }
    }
}
