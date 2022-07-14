
public enum Indentation: Equatable {
    case tab
    case spaces(Int)
}

// MARK: - Content Modifier

extension Content {

    public func indented() -> some Content {
        Indented(content: self)
    }
}

private struct Indented<C: Content>: Content {

    let content: C

    var body: some Content {
        Builtin { environment in
            content
                .generate(environment: environment)
                .map { $0.prefix(String(environment.indentation)) }
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
