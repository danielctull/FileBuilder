
import FileBuilder
import XCTest

final class TextModifierTests: XCTestCase {

    func testTextModifier() throws {

        struct Append<Line: Text>: TextModifier {
            let line: Line
            func text(content: Content) -> some Text {
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

    func testLinesModifier() throws {

        struct Suffix: LinesModifier {
            let text: String
            func lines(content: [Line]) -> [Line] {
                content.map { $0.suffix(text) }
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
