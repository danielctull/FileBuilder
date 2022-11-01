
import Foundation

public struct TextFile<Content: Text>: Text {

    private let content: Content

    public init(@TextBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some Text {
        content
    }
}
