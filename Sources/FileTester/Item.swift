
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
        fileprivate let url: URL
        fileprivate let message: String
    }
}

extension Item.Failure {

    func message(root: URL) -> String {
        "[\(url.path(relativeTo: root))] \(message)"
    }
}

extension URL {

    func path(relativeTo url: URL) -> String {
        String(path.dropFirst(url.path.count + 1))
    }
}

// MARK: - Directory

extension Item {

    public static func directory(name: String) -> Self {
        directory(name: name, items: [])
    }

    public static func directory(name: String, items: [Item]) -> Self {
        Self { url in

            try file(name: name).assert(in: url)

            let directory = url.appendingPathComponent(name)

            let contents = try FileManager()
                .contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)

            guard contents.count == items.count else {
                throw Failure(url: directory, message: "Unexpected number of items in directory. Expected \(items.count), but found \(contents.count).")
            }

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
                throw Failure(url: file, message: "File doesn't exist.")
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
                throw Failure(url: file, message: "\n\n\(data)\n\nis not equal to\n\n\(expected)")
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
                throw Failure(url: file, message: "Failed to convert data to string.")
            }

            guard string == expected else {
                throw Failure(url: file, message: "\n\n\(string)\n\nis not equal to\n\n\(expected)")
            }
        }
    }
}
