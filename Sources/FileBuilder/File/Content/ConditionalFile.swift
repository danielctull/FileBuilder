
import Foundation

extension ConditionalContent: File where True: File, False: File {

    public func write(in directory: URL) throws {
        switch value {
        case let .true(file): try file.write(in: directory)
        case let .false(file): try file.write(in: directory)
        }
    }
}
