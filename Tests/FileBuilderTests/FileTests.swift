
import FileBuilder
import FileTester
import XCTest

final class FileTests: XCTestCase {

    func testArray() throws {
        try AssertFile {
            [
                TextFile("File 1") { "One" },
                TextFile("File 2") { "Two" },
                TextFile("File 3") { "Three" },
            ]
        } outputs: {
            [
                .file(name: "File 1", text: "One"),
                .file(name: "File 2", text: "Two"),
                .file(name: "File 3", text: "Three"),
            ]
        }
    }

    func testDataFile() throws {
        let data = Data.random()
        try AssertFile {
            DataFile("File 1", data: data)
        } outputs: {
            .file(name: "File 1", data: data)
        }
    }

    func testGroup() throws {
        try AssertFile {
            Group {
                TextFile("File 1") { "One" }
                TextFile("File 2") { "Two" }
            }
        } outputs: {
            [
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
            .file(name: "File 1", text: "One")
        }
    }

    func testTextFile() throws {
        try AssertFile {
            TextFile("File 1") { "Contents" }
        } outputs: {
            .file(name: "File 1", text: "Contents")
        }
    }
}
