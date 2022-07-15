
import FileBuilder
import XCTest

final class ContentBuilderTests: XCTestCase {

    func testFirst() {
        AssertContent {
            "Hi"
        } is: {
            "Hi"
        }
    }

    func testAccumulation() {
        AssertContent {
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

    func testArray() {
        
        AssertContent {
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

    func testEither() {

        @ContentBuilder
        func content(_ bool: Bool) -> some Content {
            if bool {
                "True"
            } else {
                "False"
            }
        }

        AssertContent {
            content(true)
        } is: {
            "True"
        }

        AssertContent {
            content(false)
        } is: {
            "False"
        }
    }

    func testLimitedAvailability() {

        AssertContent {
            if #available(macOS 9999, *) {
                "Future Content"
            } else if #available(*) { // <-- This causes the builder to hit
                "Current Content"     //     buildLimitedAvailability.
            }
        } is: {
            "Current Content"
        }
    }

    func testOptional() {

        @ContentBuilder
        func content(_ bool: Bool) -> some Content {
            if bool {
                "True"
            }
        }

        AssertContent {
            content(true)
        } is: {
            "True"
        }

        AssertContent {
            content(false)
        } is: {
            ""
        }
    }
}
