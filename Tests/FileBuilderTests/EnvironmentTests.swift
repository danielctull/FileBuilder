
import FileBuilder
import XCTest

final class EnvironmentTests: XCTestCase {

    // MARK: Content

    private struct TestContent: Text {
        @Environment(\.value) var value
        var body: some Text { value }
    }

    func testContentInstallation() throws {
        try AssertText {
            TestContent().environment(\.value, "Hello!")
        } is: {
            "Hello!"
        }
    }

    func testContentNearestEnvironmentValueWins() throws {
        try AssertText {
            TestContent()
                .environment(\.value, "One")
                .environment(\.value, "Two")
                .environment(\.value, "Three")
        } is: {
            "One"
        }
    }

    // MARK: ContentModifier

    private struct TestModifier<Content: Text>: TextModifier {
        @Environment(\.value) var value
        func body(content: Content) -> some Text { value }
    }

    func testContentModifierInstallation() throws {
        try AssertText {
            Line.empty.modifier(TestModifier())
                .environment(\.value, "Hello!")
        } is: {
            "Hello!"
        }
    }

    func testContentModifierNearestEnvironmentValueWins() throws {
        try AssertText {
            Line.empty.modifier(TestModifier())
                .environment(\.value, "One")
                .environment(\.value, "Two")
                .environment(\.value, "Three")
        } is: {
            "One"
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
