
import FileBuilder
import XCTest

final class ContentTests: XCTestCase {

    func testString() {
        AssertContent { "Hello" } is: { "Hello" }
    }

    func testArray() {
        AssertContent {
            ["Hello", "World"]
        } is: {
            """
            Hello
            World
            """
        }
    }

    func testFile() {
        AssertContent {
            File {
                "Hello"
                "There"
            }
        } is: {
            """
            Hello
            There
            """
        }
    }

    func testGroup() {
        AssertContent {
            Group {
                "One"
                "Two"
            }
        } is: {
            """
            One
            Two
            """
        }
    }

    func testNoContent() {
        AssertContent {
            NoContent()
        } is: {
            ""
        }
    }

    func testOptional() {
        AssertContent {
            Group {
                String?.none
                String?.some("Just me")
            }
        } is: {
            """
            Just me
            """
        }
    }
}
