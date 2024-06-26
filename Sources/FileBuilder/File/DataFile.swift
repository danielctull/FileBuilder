
import Foundation

public struct DataFile: File {

    private let name: FileName
    private let data: () throws -> Data

    public init(_ name: FileName, data: Data) {
        self.name = name
        self.data = { data }
    }

    public init(_ name: FileName, data: @escaping () throws -> Data) {
        self.name = name
        self.data = data
    }

    public var file: some File {
        BuiltinFile { directory, _ in
            let url = directory.appending(name)
            try data().write(to: url)
        }
    }
}
