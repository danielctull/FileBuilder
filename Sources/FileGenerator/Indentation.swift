
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
        Builtin { indentation in
            content
                .generate(indentation: indentation)
                .map { Line(String(indentation) + $0.rawValue) }
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
