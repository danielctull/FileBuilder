
import FileBuilder
import XCTest

final class ContentBuilderTests: XCTestCase {

    func testFirst() throws {
        try AssertContent {
            "Hi"
        } is: {
            "Hi"
        }
    }

    func testAccumulation() throws {
        try AssertContent {
            "Hi"
            Line.empty
            "There"
        } is: {
            """
            Hi

            There
            """
        }
    }

    func testArray() throws {

        try AssertContent {
            for i in 1...3 {
                "Value \(i)"
            }
        } is: {
            """
            Value 1
            Value 2
            Value 3
            """
        }
    }

    func testEither() throws {

        @ContentBuilder
        func content(_ bool: Bool) -> some Content {
            if bool {
                "True"
            } else {
                "False"
            }
        }

        try AssertContent {
            content(true)
        } is: {
            "True"
        }

        try AssertContent {
            content(false)
        } is: {
            "False"
        }
    }

    func testLimitedAvailability() throws {

        try AssertContent {
            if #available(macOS 9999, *) {
                "Future Content"
            } else if #available(*) { // <-- This causes the builder to hit
                "Current Content"     //     buildLimitedAvailability.
            }
        } is: {
            "Current Content"
        }
    }

    func testOptional() throws {

        @ContentBuilder
        func content(_ bool: Bool) -> some Content {
            if bool {
                "True"
            }
        }

        try AssertContent {
            content(true)
        } is: {
            "True"
        }

        try AssertContent {
            content(false)
        } is: {
            ""
        }
    }
}
