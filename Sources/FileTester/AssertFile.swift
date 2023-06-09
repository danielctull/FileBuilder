
import FileBuilder
import Foundation
import XCTest

public func AssertFile<Content: File>(
    @FileBuilder content: () -> Content,
    outputs expected: () throws -> Item,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) throws {
    try AssertFile(content: content, outputs: { [try expected()] }, message(), file: file, line: line)
}

public func AssertFile<Content: File>(
    @FileBuilder content: () -> Content,
    outputs expected: () throws -> [Item],
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) throws {

    let fileManager = FileManager()

    func checkItem(_ item: Item, in directory: URL) throws {
        switch item.kind {
        case .directory(let name, let items):
            try checkDirectory(at: directory.appendingPathComponent(name), items: items)
        case .dataFile(let name, let data):
            try checkDataFile(at: directory.appendingPathComponent(name), data: data)
        }
    }

    func checkDirectory(at url: URL, items: [Item]) throws {
        XCTAssert(
            fileManager.fileExists(atPath: url.path),
            "Directory doesn't exist at \(url)",
            file: file,
            line: line)

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
        let data = try Data(contentsOf: url)
        XCTAssertEqual(
            data,
            expected,
            "\n\n\(data)\n\nis not equal to\n\n\(expected)",
            file: file,
            line: line)
    }

    try fileManager.withTemporaryDirectory { url in
        try content().write(in: url)
        try checkDirectory(at: url, items: expected())
    }
}

public struct Item {

    fileprivate let kind: Kind

    fileprivate enum Kind {
        case directory(name: String, items: [Item])
        case dataFile(name: String, data: Data)
    }
}

extension Item {

    public static func directory(name: String, items: [Item]) -> Self {
        Item(kind: .directory(name: name, items: items))
    }

    public static func file(name: String, data: Data) -> Self {
        Item(kind: .dataFile(name: name, data: data))
    }

    public static func file(name: String, text: String, encoding: String.Encoding = .utf8) throws -> Self {
        struct DataConversionError: Error {
            let value: String
        }
        guard let data = text.data(using: encoding) else { throw DataConversionError(value: text) }
        return .file(name: name, data: data)
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
