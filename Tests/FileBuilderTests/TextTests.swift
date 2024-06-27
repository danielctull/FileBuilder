
import FileBuilder
import FileBuilderTesting
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

    func testStringEmptyLine() throws {
        try AssertText {
            "Hello\n\nThere"
        } is: {
            """
            Hello

            There
            """
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
