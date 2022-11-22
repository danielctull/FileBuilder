
import Foundation

public struct DataFile: File {

    private let name: String
    private let data: Data

    public init(_ name: String, data: Data) {
        self.name = name
        self.data = data
    }

    public var file: some File {
        BuiltinFile { _ in
            [name: FileWrapper(regularFileWithContents: data)]
        }
    }
}
