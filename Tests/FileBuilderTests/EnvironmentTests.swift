
import FileBuilder
import XCTest

final class EnvironmentTests: XCTestCase {

    // MARK: Text

    private struct TestText: Text {
        @Environment(\.value) var value
        var body: some Text { value }
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

    private struct TestModifier<Content: Text>: TextModifier {
        @Environment(\.value) var value
        func body(content: Content) -> some Text { value }
    }

    func testTextModifier_installation() throws {
        try AssertText {
            Line.empty.modifier(TestModifier())
                .environment(\.value, "Hello!")
        } is: {
            "Hello!"
        }
    }

    func testTextModifier_nearestEnvironmentValueWins() throws {
        try AssertText {
            Line.empty.modifier(TestModifier())
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
        var body: some File {
            TextFile("TestFile") {
                value
            }
        }
    }

    func testFile_installation() throws {
        try AssertFile {
            TestFile().environment(\.value, "Hello!")
        } outputs: {
            try .file(name: "TestFile", text: "Hello!")
        }
    }

    func testFile_nearestEnvironmentValueWins() throws {
        try AssertFile {
            TestFile()
                .environment(\.value, "One")
                .environment(\.value, "Two")
                .environment(\.value, "Three")
        } outputs: {
            try .file(name: "TestFile", text: "One")
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
            try .file(name: "TestFile", text: "A")
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
