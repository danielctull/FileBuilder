
import FileBuilderKit
import FileBuilderTesting
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

        struct LineNumber: LinesModifier {
            func lines(content: [Line]) -> [Line] {
                content.enumerated().map { number, line in
                    line.prefix("\(number + 1) ")
                }
            }
        }

        try AssertText {
            Group {
                "Hello"
                "World"
            }
            .modifier(LineNumber())
        } is: {
            """
            1 Hello
            2 World
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
