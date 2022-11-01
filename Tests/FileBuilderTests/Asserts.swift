
import FileBuilder
import Foundation
import XCTest

public func AssertText<Content: Text>(
    @TextBuilder content: () -> Content,
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
}
