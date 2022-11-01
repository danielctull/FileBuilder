
import FileBuilder
import XCTest

final class ContentModifierTests: XCTestCase {

    func testContentModifier() throws {

        struct Append<Content: Text, Line: Text>: TextModifier {
            let line: Line
            func body(content: Content) -> some Text {
                content
                line
            }
        }

        try AssertContent {
            "Hello".modifier(Append(line: "World!"))
        } is: {
            """
            Hello
            World!
            """
        }
    }
}
