
import FileBuilder
import XCTest

final class LinesModifierTests: XCTestCase {

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

    func testLinesClosureModifier() throws {
        try AssertText {
            Group {
                "Hello"
                "World"
            }
            .modifier { $0.filter { String($0).hasPrefix("H") } }
        } is: {
            "Hello"
        }
    }

    func testLineClosureModifier() throws {
        try AssertText {
            "Hello".modifier { _ in Line.empty }
        } is: {
            ""
        }
    }
}
