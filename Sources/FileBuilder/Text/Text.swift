
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
        lines(environment: environment)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}

// MARK: - Generator

extension Text {

    func lines(environment: EnvironmentValues) -> [Line] {

        environment.install(on: self)

        if let builtin = self as? BuiltinText {
            return builtin.lines(environment: environment)
        } else {
            return body.lines(environment: environment)
        }
    }
}
