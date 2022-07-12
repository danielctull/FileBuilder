
import FileGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testBuilder() {
        let generator = FileGenerator(indentation: .spaces(2)) {
            Line("Hello")
            Line("World")
        }
        XCTAssertEqual(generator.indentation, .spaces(2))
        XCTAssertEqual(generator.contents, [
            .line("Hello"),
            .line("World")
        ])
    }
}
