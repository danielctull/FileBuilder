
import Foundation

extension Array: File where Element: File {

    public func write(in directory: URL) throws {
        for file in self {
            try file.write(in: directory)
        }
    }
}
