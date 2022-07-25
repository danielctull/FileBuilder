
import FileBuilder
import XCTest

final class LineTests: XCTestCase {

    func testPrefix() throws {
        try AssertContent {
            "Hello".modifier { $0.map { $0.prefix("!") } }
        } is: {
            "!Hello"
        }
    }

    func testSuffix() throws {
        try AssertContent {
            "Hello".modifier { $0.map { $0.suffix("!") } }
        } is: {
            "Hello!"
        }
    }
}
