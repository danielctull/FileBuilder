
import FileBuilder
import XCTest

final class EnvironmentTests: XCTestCase {

    func testContentInstallation() throws {

        struct Test: Content {
            @Environment(\.value) var value
            var body: some Content { value }
        }

        try AssertContent {
            Test().environment(\.value, "Hello!")
        } is: {
            "Hello!"
        }
    }

    func testContentModifierInstallation() throws {

        struct Test<C: Content>: ContentModifier {
            @Environment(\.value) var value
            func body(content: C) -> some Content { value }
        }

        try AssertContent {
            Line.empty.modifier(Test()).environment(\.value, "Hello!")
        } is: {
            "Hello!"
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
