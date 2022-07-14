
public protocol Content {
    associatedtype Body: Content

    @ContentBuilder
    var body: Body { get }
}

// MARK: - Generator

extension Content {

    func generate(indentation: Indentation) -> [Line] {

        if let builtin = self as? Builtin {
            return builtin.generate(indentation: indentation)
        }

        return body.generate(indentation: indentation)
    }
}
