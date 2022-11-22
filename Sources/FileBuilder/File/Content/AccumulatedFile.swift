
import Foundation

extension Accumulated: File where First: File, Second: File {

    public var file: some File {
        BuiltinFile { environment in
            let first = try first.fileWrappers(environment: environment)
            let second = try second.fileWrappers(environment: environment)
            return first.merging(second, uniquingKeysWith: { $1 })
        }
    }
}
