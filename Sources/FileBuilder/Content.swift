
import Foundation

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

    public func write(
        to url: URL,
        atomically: Bool,
        encoding: String.Encoding
    ) throws {
        // We cannot call write on String directly because String conforms to
        // Content. Therefore, this call becomes ambiguous between the one
        // defined on StringProtocol and _this_ write(to:atomically:encoding:)
        // function on Content.
        try (any StringProtocol)
            .write(content)(to: url, atomically: atomically, encoding: encoding)
    }
}

// MARK: - Generator

extension Content {

    func generate(environment: EnvironmentValues) -> [Line] {

        environment.install(on: self)

        if let builtin = self as? BuiltinContent {
            return builtin.generate(environment: environment)
        }

        return body.generate(environment: environment)
    }
}
