
import FileBuilder
import XCTest

final class TextBuilderTests: XCTestCase {

    func testFirst() throws {
        try AssertText {
            "Hi"
        } is: {
            "Hi"
        }
    }

    func testAccumulation() throws {
        try AssertText {
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

        try AssertText {
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

        @TextBuilder
        func content(_ bool: Bool) -> some Text {
            if bool {
                "True"
            } else {
                "False"
            }
        }

        try AssertText {
            content(true)
        } is: {
            "True"
        }

        try AssertText {
            content(false)
        } is: {
            "False"
        }
    }

#if !os(Linux)
    // I can't find an #available flag that exists for linux machines.
    func testLimitedAvailability() throws {

        try AssertText {
            if #available(iOS 9999, macOS 9999, tvOS 9999, watchOS 9999, *) {
                "Future Content"
            } else if #available(*) { // <-- This causes the builder to hit
                "Current Content"     //     buildLimitedAvailability.
            }
        } is: {
            "Current Content"
        }
    }
#endif

    func testOptional() throws {

        @TextBuilder
        func content(_ bool: Bool) -> some Text {
            if bool {
                "True"
            }
        }

        try AssertText {
            content(true)
        } is: {
            "True"
        }

        try AssertText {
            content(false)
        } is: {
            ""
        }
    }
}
