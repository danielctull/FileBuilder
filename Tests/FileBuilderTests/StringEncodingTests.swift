
import FileBuilderKit
import FileBuilderTesting
import XCTest

final class StringEncodingTests: XCTestCase {

    func testUTF8() throws {
        try AssertFile {
            Directory("Directory") {
                TextFile("File 1") { "One" }
                TextFile("File 2") { "Two" }
            }
            .stringEncoding(.utf8)
        } outputs: {
            .directory(name: "Directory", items: [
                .file(name: "File 1", text: "One", encoding: .utf8),
                .file(name: "File 2", text: "Two", encoding: .utf8),
            ])
        }
    }

    func testUTF16() throws {
        try AssertFile {
            Directory("Directory") {
                TextFile("File 1") { "One" }
                TextFile("File 2") { "Two" }
            }
            .stringEncoding(.utf16)
        } outputs: {
            .directory(name: "Directory", items: [
                .file(name: "File 1", text: "One", encoding: .utf16),
                .file(name: "File 2", text: "Two", encoding: .utf16),
            ])
        }
    }

    func testMixed() throws {
        try AssertFile {
            Directory("Directory") {
                TextFile("File 1") { "One" }
                TextFile("File 2") { "Two" }
            }
            .stringEncoding(.utf32BigEndian)
        } outputs: {
            .directory(name: "Directory", items: [
                .file(name: "File 1", text: "One", encoding: .utf32BigEndian),
                .file(name: "File 2", text: "Two", encoding: .utf32BigEndian),
            ])
        }
    }
}
