
import FileBuilder
import XCTest

final class LineModifierTests: XCTestCase {

    func testLineModifier() throws {

        struct Suffix<C: TextContent>: LineModifier {
            let text: String
            func modifyLines(_ lines: [Line]) -> [Line] {
                lines.map { $0.suffix(text) }
            }
        }

        try AssertContent {
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

    func testLinesClosureModifier() throws {
        try AssertContent {
            Group {
                "Hello"
                "World"
            }
            .modifier { $0.filter { $0.content.hasPrefix("H") } }
        } is: {
            "Hello"
        }
    }

    func testLineClosureModifier() throws {
        try AssertContent {
            "Hello".modifier { _ in Line.empty }
        } is: {
            ""
        }
    }
}
