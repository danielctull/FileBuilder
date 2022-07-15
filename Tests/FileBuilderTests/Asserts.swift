
import FileBuilder
import XCTest

public func AssertOutput<C: Content>(
    _ content: @autoclosure () throws -> C,
    _ value: @autoclosure () throws -> String,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(
        try content().content,
        try value(),
        message(),
        file: file,
        line: line)
}

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
