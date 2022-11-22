
import Foundation

extension Optional: File where Wrapped: File {

    public var file: some File {
        BuiltinFile { environment in
            try self?.fileWrappers(environment: environment) ?? [:]
        }
    }
}
