
import FileBuilder
import XCTest

final class DirectoryCreationTests: XCTestCase {

    func testFailIfExists() throws {
        try AssertThrows {
            Directory("Level 1") {
                Directory("Level 2") {
                    Directory("Level 3") {
                        TextFile("Test") { "Hi" }
                    }
                }
            }
            .directoryCreation(.failIfExists)

        } modifyWorkingDirectory: { url in
            try FileManager().createDirectory(
                at: url.appendingPathComponent("Level 1").appendingPathComponent("Level 2"),
                withIntermediateDirectories: true)
        }
    }

    func testFailIfExists_nothingExists() throws {
        try AssertFile {
            Directory("Level 1") {
                Directory("Level 2") {
                    Directory("Level 3") {
                        TextFile("Test") { "Hi" }
                    }
                }
            }
            .directoryCreation(.failIfExists)

        } outputs: {
            .directory(name: "Level 1", items: [
                .directory(name: "Level 2", items: [
                    .directory(name: "Level 3", items: [
                        try .file(name: "Test", text: "Hi"),
                    ])
                ])
            ])
        }
    }

    func testUseExisting() throws {
        try AssertFile {
            Directory("Level 1") {
                Directory("Level 2") {
                    Directory("Level 3") {
                        TextFile("Test") { "Hi" }
                    }
                }
            }
            .directoryCreation(.useExisting)

        } modifyWorkingDirectory: { url in
            try FileManager().createDirectory(
                at: url.appendingPathComponent("Level 1").appendingPathComponent("Level 2"),
                withIntermediateDirectories: true)

        } outputs: {
            .directory(name: "Level 1", items: [
                .directory(name: "Level 2", items: [
                    .directory(name: "Level 3", items: [
                        try .file(name: "Test", text: "Hi"),
                    ])
                ])
            ])
        }
    }

    func testUseExisting_nothingExists() throws {
        try AssertFile {
            Directory("Level 1") {
                Directory("Level 2") {
                    Directory("Level 3") {
                        TextFile("Test") { "Hi" }
                    }
                }
            }
            .directoryCreation(.useExisting)

        } outputs: {
            .directory(name: "Level 1", items: [
                .directory(name: "Level 2", items: [
                    .directory(name: "Level 3", items: [
                        try .file(name: "Test", text: "Hi"),
                    ])
                ])
            ])
        }
    }
}
