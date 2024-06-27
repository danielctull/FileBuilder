
public struct Indentation: Equatable {
    fileprivate let value: String
}

extension Indentation {
    public static let tab = Indentation(value: "\t")

    public static func spaces(_ amount: Int) -> Indentation {
        Indentation(value: String(repeating: " ", count: amount))
    }
}

// MARK: - Environment

extension Text {

    public func indentation(_ indentation: Indentation) -> some Text {
        environment(\.indentation, indentation)
    }
}

extension File {

    public func indentation(_ indentation: Indentation) -> some File {
        environment(\.indentation, indentation)
    }
}

private enum IndentationKey: EnvironmentKey {
    static let defaultValue = Indentation.spaces(4)
}

extension EnvironmentValues {

    fileprivate var indentation: Indentation {
        get { self[IndentationKey.self] }
        set { self[IndentationKey.self] = newValue }
    }
}

// MARK: - Content Modifier

extension Text {

    public func indent() -> some Text {
        modifier(Indent())
    }
}

private struct Indent: LineModifier {

    @Environment(\.indentation) var indentation

    func line(content: Line) -> Line {
        content.prefix(indentation.value)
    }
}
