
import Foundation

extension Empty: File {

    public var file: some File {
        BuiltinFile { _, _ in }
    }
}
