
public protocol TextModifier {
    typealias Content = _TextModifier_Content
    associatedtype Body: Text

    @TextBuilder
    func body(content: Content) -> Body
}

extension Text {

    public func modifier<Modifier: TextModifier>(
        _ modifier: Modifier
    ) -> Modified<Self, Modifier> {
        Modified(content: self, modifier: modifier)
    }
}

public struct _TextModifier_Content: Text {
    let content: any Text
    public var body: some Text {
        BuiltinText(lines: content.lines)
    }
}
