
import Foundation

struct BuiltinFile {

    private let _fileWrappers: (EnvironmentValues) throws -> [String: FileWrapper]

    init(fileWrappers: @escaping (EnvironmentValues) throws -> [String: FileWrapper]) {
        _fileWrappers = fileWrappers
    }

    func fileWrappers(environment: EnvironmentValues) throws -> [String: FileWrapper] {
        try _fileWrappers(environment)
    }
}

extension BuiltinFile: File {

    var file: some File {
        fatalError("Builtin file should not be called.")
    }
}
