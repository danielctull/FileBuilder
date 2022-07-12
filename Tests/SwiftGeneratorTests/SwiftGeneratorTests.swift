
import FileGenerator
import SwiftGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testGeneration() {
        let file = File(indentation: .spaces(2)) {
            Function(name: "function")
            "Hello"
            Section(header: "Header", footer: "Footer") {
                "Line 1.1"
                Section(header: "Header 2") {
                    "Line 2.1"
                    "Line 2.2"
                }
                "Line 1.2"
            }
            "World"
        }
        XCTAssertEqual(file.content, """
        func function() {
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
