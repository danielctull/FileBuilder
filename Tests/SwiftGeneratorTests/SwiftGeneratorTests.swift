
import FileGenerator
import SwiftGenerator
import XCTest

final class FileGeneratorTests: XCTestCase {

    func testGeneration() {
        let file = File {
            Func(.public, name: "function") {
                "let this and var that"
            }
        }
        .indentation(.spaces(2))
        
        XCTAssertEqual(file.content, """
        public func function() {
          let this and var that
        }
        """)
    }
}
