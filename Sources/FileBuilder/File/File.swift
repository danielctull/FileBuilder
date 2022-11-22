
import Foundation

public protocol File {
    associatedtype SomeFile: File

    @FileBuilder
    var file: SomeFile { get }
}

extension File {

    public func write(in directory: URL) throws {
        let fileWrappers = try fileWrappers(environment: EnvironmentValues())
        for (name, fileWrapper) in fileWrappers {
            let url = directory.appendingPathComponent(name)
            try fileWrapper.write(to: url, originalContentsURL: nil)
        }
    }

    func fileWrappers(environment: EnvironmentValues) throws -> [String: FileWrapper] {

        environment.install(on: self)

        if let builtin = self as? BuiltinFile {
            return try builtin.fileWrappers(environment: environment)
        } else {
            return try file.fileWrappers(environment: environment)
        }
    }
}
