
import FileBuilder
import XCTest

final class EnvironmentTests: XCTestCase {

    // MARK: Content

    private struct TestContent: TextContent {
        @Environment(\.value) var value
        var body: some TextContent { value }
    }

    func testContentInstallation() throws {
        try AssertContent {
            TestContent().environment(\.value, "Hello!")
        } is: {
            "Hello!"
        }
    }

    func testContentNearestEnvironmentValueWins() throws {
        try AssertContent {
            TestContent()
                .environment(\.value, "One")
                .environment(\.value, "Two")
                .environment(\.value, "Three")
        } is: {
            "One"
        }
    }

    // MARK: ContentModifier

    private struct TestModifier<C: TextContent>: ContentModifier {
        @Environment(\.value) var value
        func body(content: C) -> some TextContent { value }
    }

    func testContentModifierInstallation() throws {
        try AssertContent {
            Line.empty.modifier(TestModifier())
                .environment(\.value, "Hello!")
        } is: {
            "Hello!"
        }
    }

    func testContentModifierNearestEnvironmentValueWins() throws {
        try AssertContent {
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
