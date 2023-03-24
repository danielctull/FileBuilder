
import Foundation

public protocol Text {
    associatedtype Body: Text

    @TextBuilder
    var body: Body { get throws }
}

extension String {

    public init(_ text: some Text) throws {
        try self.init(text, environment: EnvironmentValues())
    }

    init(_ text: some Text, environment: EnvironmentValues) throws {
        self = try text
            .lines(environment: environment)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}

// MARK: - Generator

extension Text {

    func lines(environment: EnvironmentValues) throws -> [Line] {

        environment.install(on: self)

        if let builtin = self as? BuiltinText {
            return try builtin.lines(environment: environment)
        } else {
            return try body.lines(environment: environment)
        }
    }
}
