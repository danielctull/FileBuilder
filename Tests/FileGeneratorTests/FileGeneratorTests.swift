
import FileGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testGeneration() {
        let generator = FileGenerator(indentation: .spaces(2)) {
            Line("Hello")
            Section(header: "Header", footer: "Footer") {
                Line("Line 1.1")
                Section(header: "Header 2") {
                    Line("Line 2.1")
                    Line("Line 2.2")
                }
                Line("Line 1.2")
            }
            Line("World")
        }
        XCTAssertEqual(generator(), """
        Hello
        Header
          Line 1.1
          Header 2
            Line 2.1
            Line 2.2
          Line 1.2
        Footer
        World
        """)
    }
}
