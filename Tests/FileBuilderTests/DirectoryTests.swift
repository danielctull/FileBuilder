
import FileBuilderKit
import FileTester
import XCTest

final class DirectoryTests: XCTestCase {

    func testEmpty() throws {
        try AssertFile {
            Directory("Directory")
        } outputs: {
            [
                .directory(name: "Directory", items: []),
            ]
        }
    }
}
