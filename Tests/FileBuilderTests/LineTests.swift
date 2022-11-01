
import FileBuilder
import XCTest

final class LineTests: XCTestCase {

    func testPrefix() throws {
        try AssertText {
            "Hello".modifier { $0.prefix("!") }
        } is: {
            "!Hello"
        }
    }

    func testSuffix() throws {
        try AssertText {
            "Hello".modifier { $0.suffix("!") }
        } is: {
            "Hello!"
        }
    }
}
