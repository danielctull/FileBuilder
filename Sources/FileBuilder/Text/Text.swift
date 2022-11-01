
import Foundation

public protocol Text {
    associatedtype Body: Text

    @TextBuilder
    var body: Body { get }
}

extension Text {

    public var content: String {
        content(environment: EnvironmentValues())
    }

    func content(environment: EnvironmentValues) -> String {
        generate(environment: environment)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}

// MARK: - Generator

extension Text {

    func generate(environment: EnvironmentValues) -> [Line] {

        environment.install(on: self)

        if let builtin = self as? BuiltinText {
            return builtin.generate(environment: environment)
        }

        return body.generate(environment: environment)
    }
}