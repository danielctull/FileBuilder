
import FileBuilder
import XCTest

final class FileTests: XCTestCase {

    func testAnyFile() throws {
        try AssertFile {
            AnyFile(TextFile("File 1") { "One" })
        } outputs: {
            try .file(name: "File 1", text: "One")
        }
    }

    func testArray() throws {
        try AssertFile {
            [
                TextFile("File 1") { "One" },
                TextFile("File 2") { "Two" },
                TextFile("File 3") { "Three" },
            ]
        } outputs: {
            try [
                .file(name: "File 1", text: "One"),
                .file(name: "File 2", text: "Two"),
                .file(name: "File 3", text: "Three"),
            ]
        }
    }

    func testGroup() throws {
        try AssertFile {
            Group {
                TextFile("File 1") { "One" }
                TextFile("File 2") { "Two" }
            }
        } outputs: {
            try [
                .file(name: "File 1", text: "One"),
                .file(name: "File 2", text: "Two"),
            ]
        }
    }

    func testOptional() throws {
        try AssertFile {
            TextFile<String>?.none
            TextFile<String>?.some(TextFile("File 1") { "One" })
        } outputs: {
            try .file(name: "File 1", text: "One")
        }
    }
}
