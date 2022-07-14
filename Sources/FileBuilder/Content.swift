
public protocol Content {
    associatedtype Body: Content

    @ContentBuilder
    var body: Body { get }
}

extension Content {

    public var content: String {
        generate(environment: EnvironmentValues())
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}

// MARK: - Generator

extension Content {

    func generate(environment: EnvironmentValues) -> [Line] {

        environment.install(on: self)

        if let builtin = self as? Builtin {
            return builtin.generate(environment: environment)
        }

        return body.generate(environment: environment)
    }
}
