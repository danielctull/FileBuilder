
import FileBuilder
import FileTester
import XCTest

final class EnvironmentTests: XCTestCase {

    // MARK: Text

    private struct TestText: Text {
        @Environment(\.value) var value
        var text: some Text { value }
    }

    func testText_installation() throws {
        try AssertText {
            TestText().environment(\.value, "Hello!")
        } is: {
            "Hello!"
        }
    }

    func testText_nearestEnvironmentValueWins() throws {
        try AssertText {
            TestText()
                .environment(\.value, "One")
                .environment(\.value, "Two")
                .environment(\.value, "Three")
        } is: {
            "One"
        }
    }

    // MARK: TextModifier

    private struct TestTextModifier: TextModifier {
        @Environment(\.value) var value
        func text(content: Content) -> some Text { value }
    }

    func testTextModifier_installation() throws {
        try AssertText {
            Line.empty.modifier(TestTextModifier())
                .environment(\.value, "Hello!")
        } is: {
            "Hello!"
        }
    }

    func testTextModifier_nearestEnvironmentValueWins() throws {
        try AssertText {
            Line.empty.modifier(TestTextModifier())
                .environment(\.value, "One")
                .environment(\.value, "Two")
                .environment(\.value, "Three")
        } is: {
            "One"
        }
    }

    // MARK: File

    private struct TestFile: File {
        @Environment(\.value) var value
        var file: some File {
            TextFile("TestFile") {
                value
            }
        }
    }

    func testFile_installation() throws {
        try AssertFile {
            TestFile().environment(\.value, "Hello!")
        } outputs: {
            .file(name: "TestFile", text: "Hello!")
        }
    }

    func testFile_nearestEnvironmentValueWins() throws {
        try AssertFile {
            TestFile()
                .environment(\.value, "One")
                .environment(\.value, "Two")
                .environment(\.value, "Three")
        } outputs: {
            .file(name: "TestFile", text: "One")
        }
    }

    func testFile_textEnvironmentValueWins() throws {
        try AssertFile {
            TextFile("TestFile") {
                TestText()
                    .environment(\.value, "A")
                    .environment(\.value, "B")
                    .environment(\.value, "C")
            }
            .environment(\.value, "One")
            .environment(\.value, "Two")
            .environment(\.value, "Three")
        } outputs: {
            .file(name: "TestFile", text: "A")
        }
    }

    // MARK: FileModifier

    private struct TestFileModifier: FileModifier {
        @Environment(\.value) var value
        func file(content: Content) -> some File {
            TextFile("Replaced") { value }
        }
    }

    func testFileModifier_installation() throws {
        try AssertFile {
            TestFile()
                .modifier(TestFileModifier())
                .environment(\.value, "Foo")
        } outputs: {
            .file(name: "Replaced", text: "Foo")
        }
    }

    func testFileModifier_nearestEnvironmentValueWins() throws {
        try AssertFile {
            TestFile()
                .modifier(TestFileModifier())
                .environment(\.value, "One")
                .environment(\.value, "Two")
                .environment(\.value, "Three")
        } outputs: {
            .file(name: "Replaced", text: "One")
        }
    }
}

private enum ValueKey: EnvironmentKey {
    static let defaultValue = ""
}

extension EnvironmentValues {

    fileprivate var value: String {
        get { self[ValueKey.self] }
        set { self[ValueKey.self] = newValue }
    }
}
