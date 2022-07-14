
public enum Indentation: Equatable {
    case tab
    case spaces(Int)
}

// MARK: - Environment

extension Content {

    public func indentation(_ indentation: Indentation) -> some Content {
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

extension Content {

    public func indented() -> some Content {
        Indented(content: self)
    }
}

private struct Indented<C: Content>: Content {

    @Environment(\.indentation) var indentation
    let content: C

    var body: some Content {
        Builtin { environment in
            content
                .generate(environment: environment)
                .map { $0.prefix(String(indentation)) }
        }
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
