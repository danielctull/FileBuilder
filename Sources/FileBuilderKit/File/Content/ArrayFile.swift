
import Foundation

extension Array: File where Element: File {

    public var file: some File {
        BuiltinFile { directory, environment in
            for file in self {
                try file.write(in: directory, environment: environment)
            }
        }
    }
}
