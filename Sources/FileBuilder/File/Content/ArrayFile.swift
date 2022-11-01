
import Foundation

extension Array: File where Element: File {

    public var body: some File {
        BuiltinFile { directory, environment in
            for file in self {
                try file.write(in: directory, environment: environment)
            }
        }
    }
}
