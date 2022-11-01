
import Foundation

extension Optional: File where Wrapped: File {

    public var body: some File {
        BuiltinFile { directory, environment in
            try self?.write(in: directory, environment: environment)
        }
    }
}
