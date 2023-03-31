
public enum Indentation: Equatable {
    case tab
    case spaces(Int)
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

private struct Indent: LinesModifier {

    @Environment(\.indentation) var indentation

    func modifyLines(_ lines: [Line]) -> [Line] {
        lines.map { $0.prefix(String(indentation)) }
    }
}

extension String {

    fileprivate init(_ indentation: Indentation) {
        switch indentation {
        case .tab: self = "\t"
        case .spaces(let amount): self = String(repeating: " ", count: amount)
        }
    }
}
