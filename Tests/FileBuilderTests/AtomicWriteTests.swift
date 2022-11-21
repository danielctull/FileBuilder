
import FileBuilder
import XCTest

final class AtomicWriteTests: XCTestCase {

    func testFile() throws {
        try AssertFile {
            TextFile("Test") {
                "Hi"
            }
            .writeAtomically()
        } outputs: {
            try .file(name: "Test", text: "Hi")
        }
    }

    func testDirectory() throws {
        try AssertFile {
            Directory("Directory") {
                TextFile("File 1") { "One" }
                TextFile("File 2") { "Two" }
            }
            .writeAtomically()
        } outputs: {
            try .directory(name: "Directory", items: [
                .file(name: "File 1", text: "One"),
                .file(name: "File 2", text: "Two"),
            ])
        }
    }
}
