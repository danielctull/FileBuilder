
import Foundation

extension Array: File where Element: File {

    public var file: some File {
        BuiltinFile { environment in
            try reduce(into: [:]) { result, file in
                result.merge(try file.fileWrappers(environment: environment)) { $1 }
            }
        }
    }
}
