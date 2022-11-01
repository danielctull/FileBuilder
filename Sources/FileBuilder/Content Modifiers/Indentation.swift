
public enum Indentation: Equatable {
    case tab
    case spaces(Int)
}

// MARK: - Environment

extension TextContent {

    public func indentation(_ indentation: Indentation) -> some TextContent {
        environment(\.indentation, indentation)
    }
}

enum IndentationKey: EnvironmentKey {
    static let defaultValue = Indentation.spaces(4)
}

extension EnvironmentValues {

    var indentation: Indentation {
        get { self[IndentationKey.self] }
        set { self[IndentationKey.self] = newValue }
    }
}

// MARK: - Content Modifier

extension TextContent {

    public func indented() -> some TextContent {
        modifier(Indented())
    }
}

private struct Indented<C: TextContent>: LineModifier {

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
