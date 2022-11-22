
import Foundation

extension Either: File where First: File, Second: File {

    public var file: some File {
        BuiltinFile { environment in
            switch value {
            case let .first(file):
                return try file.fileWrappers(environment: environment)
            case let .second(file):
                return try file.fileWrappers(environment: environment)
            }
        }
    }
}
