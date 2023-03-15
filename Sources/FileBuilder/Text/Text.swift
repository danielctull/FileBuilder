
import Foundation

public protocol Text {
    associatedtype Body: Text

    @TextBuilder
    var body: Body { get }
}

extension Text {

    func content(environment: EnvironmentValues) -> String {
        lines(environment: environment)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}

extension String {

    public init(_ text: some Text) {
        self = text.content(environment: EnvironmentValues())
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
