
import Foundation

public struct Item {

    private let _assert: (URL) throws -> Void

    init(assert: @escaping (URL) throws -> Void) {
        _assert = assert
    }

    func assert(in url: URL) throws {
        try _assert(url)
    }
}

// MARK: - Failure

extension Item {

    struct Failure: Error {
        fileprivate let file: URL
        fileprivate let message: String
    }
}

extension Item.Failure {

    func message(rootURL url: URL) -> String {
        let path = file.path.dropFirst(url.path.count + 1)
        return "[\(path)] \(message)"
    }
}

// MARK: - Directory

extension Item {

    public static func directory(name: String) -> Self {
        directory(name: name, items: [])
    }

    public static func directory(name: String, items: [Item]) -> Self {
        Item { url in

            try file(name: name).assert(in: url)

            let directory = url.appendingPathComponent(name)
            for item in items {
                try item.assert(in: directory)
            }
        }
    }
}

// MARK: - File Exists

extension Item {

    public static func file(name: String) -> Self {
        Item { url in

            let file = url.appendingPathComponent(name)

            guard FileManager().fileExists(atPath: file.path) else {
                throw Failure(file: file, message: "File doesn't exist.")
            }
        }
    }
}

// MARK: - Data File

extension Item {

    public static func file(name: String, data expected: Data) -> Self {
        Item { url in

            try file(name: name).assert(in: url)

            let file = url.appendingPathComponent(name)
            let data = try Data(contentsOf: file)

            guard data == expected else {
                throw Failure(file: file, message: "\n\n\(data)\n\nis not equal to\n\n\(expected)")
            }
        }
    }
}

// MARK: - Text File

extension Item {

    public static func file(
        name: String,
        text expected: String,
        encoding: String.Encoding = .utf8
    ) -> Self {
        Item { url in

            try file(name: name).assert(in: url)

            let file = url.appendingPathComponent(name)
            let data = try Data(contentsOf: file)

            guard let string = String(data: data, encoding: encoding) else {
                throw Failure(file: file, message: "Failed to convert data to string.")
            }

            guard string == expected else {
                throw Failure(file: file, message: "\n\n\(string)\n\nis not equal to\n\n\(expected)")
            }
        }
    }
}
