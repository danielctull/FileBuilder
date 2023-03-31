
public struct AnyText: Text {

    private let content: any Text

    public init(_ content: some Text) {
        self.content = content
    }

    public var text: some Text {
        BuiltinText(lines: content.lines)
    }
}
