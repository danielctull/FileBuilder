
import Foundation

public protocol File {
    associatedtype Body: File

    @FileBuilder
    var body: Body { get }
}

extension File {

    public func write(in directory: URL) throws {
        try write(in: directory, environment: EnvironmentValues())
    }

    func write(in directory: URL, environment: EnvironmentValues) throws {

        environment.install(on: self)

        if let builtin = self as? BuiltinFile {
            try builtin.write(in: directory, environment: environment)
        } else {
            try body.write(in: directory, environment: environment)
        }
    }
}
