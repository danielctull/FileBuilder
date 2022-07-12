
import FileGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testBuilder() {
        let generator = FileGenerator(indentation: .spaces(2)) {
            Line("Hello")
            Section {
                Line("")
            }
            Line("World")
        }
        XCTAssertEqual(generator.indentation, .spaces(2))
        XCTAssertEqual(generator.contents, [
            .line("Hello"),
            .section(Section {
                Line("")
            }),
            .line("World")
        ])
    }

    func testGeneration() {
        let generator = FileGenerator(indentation: .spaces(2)) {
            Line("Hello")
            Section {
                Line("There")
            }
            Line("World")
        }
        XCTAssertEqual(generator(), """
        Hello
          There
        World
        """)
    }
}
