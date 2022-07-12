
import FileGenerator
import SwiftGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testGeneration() {
        let file = File(indentation: .spaces(2)) {
            Func(name: "function") {
                "let this and var that"
            }
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
          let this and var that
        }
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
