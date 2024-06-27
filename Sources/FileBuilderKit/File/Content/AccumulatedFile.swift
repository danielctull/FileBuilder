
import Foundation

extension Accumulated: File where First: File, Second: File {

    public var file: some File {
        BuiltinFile { directory, environment in
            try first.write(in: directory, environment: environment)
            try second.write(in: directory, environment: environment)
        }
    }
}
