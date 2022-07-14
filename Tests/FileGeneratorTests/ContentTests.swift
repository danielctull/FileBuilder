
import FileGenerator
import XCTest

final class ContentTests: XCTestCase {

    func testString() {
        AssertOutput("Hello", "Hello")
    }

    func testArray() {
        AssertOutput(
            ["Hello", "World"],
            """
            Hello
            World
            """)
    }

    func testFile() {
        AssertOutput(
            File {
                "Hello"
                "There"
            },
            """
            Hello
            There
            """)
    }

    func testGroup() {
        AssertOutput(
            Group {
                "One"
                "Two"
            },
            """
            One
            Two
            """)
    }

    func testOptional() {
        AssertOutput(
            Group {
                String?.none
                String?.some("Just me")
            },
            """
            Just me
            """)
    }
}
