
import FileBuilder
import Foundation
import XCTest

public func AssertFile(
    @FileBuilder content: () -> some File,
    outputs expected: () throws -> Item,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) throws {
    try AssertFile(content: content, outputs: { [try expected()] }, message(), file: file, line: line)
}

public func AssertFile(
    @FileBuilder content: () -> some File,
    outputs expected: () throws -> [Item],
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) throws {

    let fileManager = FileManager()

    try fileManager.withTemporaryDirectory { url in
        try content().write(in: url)
        try checkDirectory(at: url, items: expected())
    }

    func checkItem(_ item: Item, in directory: URL) throws {
        switch item.kind {
        case .directory(let name, let items):
            try checkDirectory(at: directory.appendingPathComponent(name), items: items)
        case .fileExists(let name):
            checkFileExists(at: directory.appendingPathComponent(name), kind: "File")
        case .dataFile(let name, let data):
            try checkDataFile(at: directory.appendingPathComponent(name), data: data)
        case .textFile(let name, let text, let encoding):
            try checkTextFile(at: directory.appendingPathComponent(name), text: text, encoding: encoding)
        }
    }

    func checkDirectory(at url: URL, items: [Item]) throws {

        guard checkFileExists(at: url, kind: "Directory") else { return }

        let contents = try fileManager.contentsOfDirectory(atPath: url.path)
        XCTAssertEqual(
            contents.count,
            items.count,
            "Directory at \(url) doesn't contain the correct number of items",
            file: file,
            line: line)

        for item in items {
            try checkItem(item, in: url)
        }
    }

    func checkDataFile(at url: URL, data expected: Data) throws {

        guard checkFileExists(at: url, kind: "File") else { return }

        let data = try Data(contentsOf: url)
        XCTAssertEqual(
            data,
            expected,
            "\n\n\(data)\n\nis not equal to\n\n\(expected)",
            file: file,
            line: line)
    }

    func checkTextFile(at url: URL, text expected: String, encoding: String.Encoding) throws {

        guard checkFileExists(at: url, kind: "File") else { return }

        let data = try Data(contentsOf: url)
        let string = try XCTUnwrap(String(data: data, encoding: encoding))
        XCTAssertEqual(
            string,
            expected,
            "\n\n\(string)\n\nis not equal to\n\n\(expected)",
            file: file,
            line: line)
    }

    @discardableResult
    func checkFileExists(at url: URL, kind: String) -> Bool {

        let fileExists = fileManager.fileExists(atPath: url.path)

        XCTAssert(
            fileExists,
            "\(kind) doesn't exist at \(url)",
            file: file,
            line: line)

        return fileExists
    }
}

public struct Item {

    fileprivate let kind: Kind

    fileprivate enum Kind {
        case directory(name: String, items: [Item])
        case fileExists(name: String)
        case dataFile(name: String, data: Data)
        case textFile(name: String, text: String, encoding: String.Encoding)
    }
}

extension Item {

    public static func directory(name: String) -> Self {
        Item(kind: .directory(name: name, items: []))
    }

    public static func directory(name: String, items: [Item]) -> Self {
        Item(kind: .directory(name: name, items: items))
    }
    
    /// Checks that the file exists on disk.
    ///
    /// This doesn't check the contents of the file, merely that it exists.
    ///
    /// - Parameter name: The name of the file
    /// - Returns: An item representing a file exists check.
    public static func file(name: String) -> Self {
        Item(kind: .fileExists(name: name))
    }

    public static func file(name: String, data: Data) -> Self {
        Item(kind: .dataFile(name: name, data: data))
    }

    public static func file(name: String, text: String, encoding: String.Encoding = .utf8) -> Self {
        Item(kind: .textFile(name: name, text: text, encoding: encoding))
    }
}

extension FileManager {

    fileprivate func withTemporaryDirectory(_ perform: (URL) throws -> Void) throws {
        let url = temporaryDirectory
            .appendingPathComponent("FileBuilderTests")
            .appendingPathComponent(UUID().uuidString)
        defer { try? removeItem(at: url) }
        try createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
        try perform(url)
    }
}
