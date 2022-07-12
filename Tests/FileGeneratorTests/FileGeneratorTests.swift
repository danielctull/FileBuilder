
import FileGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testInit() {
        do {
            let generator = FileGenerator(lines: ["Hello", "World"])
            XCTAssertEqual(generator.indentation, .spaces(4))
            XCTAssertEqual(generator.lines, ["Hello", "World"])
        }
        do {
            let generator = FileGenerator(indentation: .tab, lines: ["Hello"])
            XCTAssertEqual(generator.indentation, .tab)
            XCTAssertEqual(generator.lines, ["Hello"])
        }
    }

    func testBuilder() {
        let generator = FileGenerator(indentation: .spaces(2)) {
            Line("Hello")
            Line("World")
        }

        XCTAssertEqual(generator.indentation, .spaces(2))
        XCTAssertEqual(generator.lines, ["Hello", "World"])
    }
}
