
import FileBuilder
import FileTester
import XCTest

final class DirectoryTests: XCTestCase {
    
    func testEmpty() throws {
        try AssertFile {
            Directory("Explicit") { Empty() }
            Directory("Implicit")
        } outputs: {
            [
                .directory(name: "Explicit", items: []),
                .directory(name: "Implicit", items: []),
            ]
        }
    }
}
