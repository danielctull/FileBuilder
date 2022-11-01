
import FileBuilder
import Foundation
import XCTest

public func AssertContent<Content: TextContent>(
    @ContentBuilder content: () -> Content,
    is expected: () -> String,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) throws {
    let output = content().content
    let expected = expected()

    XCTAssert(
        output == expected,
        "\n\n\(output)\n\nis not equal to\n\n\(expected)",
        file: file,
        line: line)

    try FileManager().withTemporaryDirectory { url in
        let url = url.appendingPathComponent(UUID().uuidString)
        try content().write(to: url, atomically: true, encoding: .utf8)
        let result = try String(contentsOf: url)
        XCTAssert(
            result == expected,
            "\n\n\(result)\n\nis not equal to\n\n\(expected)",
            file: file,
            line: line)
    }
}

extension FileManager {

    func withTemporaryDirectory(_ perform: (URL) throws -> Void) throws {
        let url = temporaryDirectory
            .appendingPathComponent("FileBuilderTests")
            .appendingPathComponent(UUID().uuidString)
        try createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
        try perform(url)
        try removeItem(at: url)
    }
}
