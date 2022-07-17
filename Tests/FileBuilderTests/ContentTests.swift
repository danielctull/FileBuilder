
import FileBuilder
import XCTest

final class ContentTests: XCTestCase {

    func testString() throws {
        try AssertContent { "Hello" } is: { "Hello" }
    }

    func testAnyContent() throws {
        try AssertContent {
            AnyContent("Anything!")
        } is: {
            "Anything!"
        }
    }

    func testArray() throws {
        try AssertContent {
            ["Hello", "World"]
        } is: {
            """
            Hello
            World
            """
        }
    }

    func testFile() throws {
        try AssertContent {
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

    func testGroup() throws {
        try AssertContent {
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

    func testNoContent() throws {
        try AssertContent {
            NoContent()
        } is: {
            ""
        }
    }

    func testOptional() throws {
        try AssertContent {
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
