
import Foundation

extension Accumulated: File where First: File, Second: File {

    public var body: some File {
        BuiltinFile { directory, environment in
            try first.write(in: directory, environment: environment)
            try second.write(in: directory, environment: environment)
        }
    }
}
