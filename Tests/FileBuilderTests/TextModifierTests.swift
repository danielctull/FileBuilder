
import FileBuilder
import XCTest

final class TextModifierTests: XCTestCase {

    func testTextModifier() throws {

        struct Append<Content: Text, Line: Text>: TextModifier {
            let line: Line
            func body(content: Content) -> some Text {
                content
                line
            }
        }

        try AssertText {
            "Hello".modifier(Append(line: "World!"))
        } is: {
            """
            Hello
            World!
            """
        }
    }
}