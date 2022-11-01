
import FileBuilder
import XCTest

final class ContentModifierTests: XCTestCase {

    func testContentModifier() throws {

        struct Append<Content: TextContent, Line: TextContent>: ContentModifier {
            let line: Line
            func body(content: Content) -> some TextContent {
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
