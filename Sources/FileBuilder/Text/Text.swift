
import Foundation

public protocol Text {
    associatedtype SomeText: Text

    @TextBuilder
    var text: SomeText { get }
}

extension String {

    public init(_ text: some Text) {
        self.init(text, environment: EnvironmentValues())
    }

    init(_ text: some Text, environment: EnvironmentValues) {
        self = text
            .lines(environment: environment)
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
            return text.lines(environment: environment)
        }
    }
}
