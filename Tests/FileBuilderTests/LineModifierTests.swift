
import FileBuilder
import XCTest

final class LineModifierTests: XCTestCase {

    func testLineModifier() throws {

        struct Suffix: LineModifier {
            let text: String
            func line(content: Line) -> Line {
                content.suffix(text)
            }
        }

        try AssertText {
            Group {
                "Hello"
                "World"
            }
            .modifier(Suffix(text: "!"))
        } is: {
            """
            Hello!
            World!
            """
        }
    }
}
