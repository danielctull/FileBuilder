
import FileBuilderKit
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
        for item in try expected() {
            do {
                try item.assert(in: url)
            } catch let failure as Item.Failure {
                XCTFail(
                    failure.message(root: url),
                    file: file,
                    line: line)
            } catch {
                throw error
            }
        }
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
