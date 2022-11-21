
import FileBuilder
import XCTest

final class FileModifierTests: XCTestCase {

    func testFileModifier() throws {

        struct Insert<Content: File, Addition: File>: FileModifier {
            let addition: Addition
            func body(content: Content) -> some File {
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
                try .file(name: "File 1", text: "One"),
                try .file(name: "File 2", text: "Two"),
            ]
        }
    }
}
