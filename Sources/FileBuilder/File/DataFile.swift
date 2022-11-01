
import Foundation

public struct DataFile: File {

    private let name: String
    private let data: Data

    public init(_ name: String, data: Data) {
        self.name = name
        self.data = data
    }

    public var body: some File {
        BuiltinFile { directory, _ in
            let url = directory.appendingPathComponent(name)
            try data.write(to: url)
        }
    }
}
