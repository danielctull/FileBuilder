
import FileGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testInit() {
        XCTAssertEqual(FileGenerator().indentation, .spaces(4))
        XCTAssertEqual(FileGenerator(indentation: .tab).indentation, .tab)
        XCTAssertEqual(FileGenerator(indentation: .spaces(2)).indentation, .spaces(2))
    }
}
