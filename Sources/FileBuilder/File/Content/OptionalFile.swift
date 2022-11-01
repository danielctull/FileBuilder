
import Foundation

extension Optional: File where Wrapped: File {

    public func write(in directory: URL) throws {
        try self?.write(in: directory)
    }
}
