
import Foundation

extension AccumulatedContent: File where First: File, Second: File {

    public func write(in directory: URL) throws {
        try first.write(in: directory)
        try second.write(in: directory)
    }
}
