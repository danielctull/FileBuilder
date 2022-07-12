
import FileGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testGeneration() {

        let file = File(indentation: .spaces(2)) {
            "Hello"
            Section(header: "Header", footer: "Footer") {
                "Line 1.1"
                Section(header: "Header 2") {
                    for i in 1...5 {
                        "Line 2.\(i)"
                    }
                }
                "Line 1.2"
            }
            "World"
        }

        XCTAssertEqual(file.content, """
        Hello
        Header
          Line 1.1
          Header 2
            Line 2.1
            Line 2.2
            Line 2.3
            Line 2.4
            Line 2.5
          Line 1.2
        Footer
        World
        """)
    }
}
