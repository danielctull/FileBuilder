
import Foundation

public struct DataFile: File {

    private let name: FileName
    private let data: () throws -> Data

    public init(_ name: FileName, data: Data) {
        self.name = name
        self.data = { data }
    }

    public init<Value>(
        _ name: FileName,
        format: Format<Value>,
        value: @escaping () -> Value
    ) {
        self.name = name
        self.data = { try format(value()) }
    }

    public var file: some File {
        BuiltinFile { directory, _ in
            let url = directory.appending(name)
            try data().write(to: url)
        }
    }
}

// MARK: - Format

public struct Format<Value> {

    private let convert: (Value) throws -> Data
    fileprivate init(convert: @escaping (Value) throws -> Data) {
        self.convert = convert
    }

    fileprivate func callAsFunction(_ value: Value) throws -> Data {
        try convert(value)
    }
}

extension Format where Value: Encodable {

    public static var json: Self {
        Self { value in
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            return try encoder.encode(value)
        }
    }
}
