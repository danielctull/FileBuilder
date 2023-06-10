
import FileBuilder
import FileTester
import XCTest

final class FileModifierTests: XCTestCase {

    func testFileModifier() throws {

        struct Insert<Addition: File>: FileModifier {
            let addition: Addition
            func file(content: Content) -> some File {
                content
                addition
            }
        }

        try AssertFile {
            TextFile("File 1") { "One" }
                .modifier(Insert(addition: TextFile("File 2") {
                    "Two"
                }))
        } outputs: {
            [
                .file(name: "File 1", text: "One"),
                .file(name: "File 2", text: "Two"),
            ]
        }
    }
}
