
import FileBuilder
import XCTest

public func AssertContent<C: Content>(
    @ContentBuilder content: () -> C,
    is output: () -> String,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(
        content().content,
        output(),
        message(),
        file: file,
        line: line)
}
