
public protocol Content {
    associatedtype Body: Content

    @ContentBuilder
    var body: Body { get }
}

// MARK: - Generator

extension Content {

    func generate(environment: EnvironmentValues) -> [Line] {

        if let builtin = self as? Builtin {
            return builtin.generate(environment: environment)
        }

        return body.generate(environment: environment)
    }
}
