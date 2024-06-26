import Foundation

public struct JSONFile<Value: Encodable>: File {

    private let name: FileName
    private let value: Value

    public init(_ name: FileName, value: () -> Value) {
        self.name = name
        self.value = value()
    }

    public var file: some File {
        BuiltinFile { directory, _ in
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let data = try encoder.encode(value)
            let url = directory.appending(name)
            try data.write(to: url)
        }
    }
}
