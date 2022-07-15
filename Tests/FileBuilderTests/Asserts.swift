
import FileBuilder
import XCTest

public func AssertContent<C: Content>(
    @ContentBuilder content: () -> C,
    is output: () -> String,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let content = content().content
    let output = output()
    XCTAssert(
        content == output,
        "\n\n\(content)\n\nis not equal to\n\n\(output)",
        file: file,
        line: line)
}
