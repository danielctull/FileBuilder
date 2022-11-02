
import FileBuilder
import XCTest

final class TextTests: XCTestCase {

    func testString() throws {
        try AssertText { "Hello" } is: { "Hello" }
    }

    func testStringMultipleLines() throws {
        try AssertText {
            "Hello\nThere"
        } is: {
            """
            Hello
            There
            """
        }
    }

    func testAnyContent() throws {
        try AssertText {
            AnyText("Anything!")
        } is: {
            "Anything!"
        }
    }

    func testArray() throws {
        try AssertText {
            ["Hello", "World"]
        } is: {
            """
            Hello
            World
            """
        }
    }

    func testGroup() throws {
        try AssertText {
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
        try AssertText {
            EmptyText()
        } is: {
            ""
        }
    }

    func testOptional() throws {
        try AssertText {
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
