
import FileGenerator
import SwiftGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testGeneration() {
        let file = File(indentation: .spaces(2)) {
            Func(.public, name: "function") {
                "let this and var that"
            }
        }
        XCTAssertEqual(file.content, """
        public func function() {
          let this and var that
        }
        """)
    }
}
