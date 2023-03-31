
extension Text {

    public func modifier<Modifier: TextModifier>(
        _ modifier: Modifier
    ) -> Modified<Self, Modifier> {
        Modified(content: self, modifier: modifier)
    }
}

public protocol TextModifier {
    typealias Content = _TextModifier_Content
    associatedtype SomeText: Text

    @TextBuilder
    func text(content: Content) -> SomeText
}

public struct _TextModifier_Content: Text {
    let content: any Text
    public var text: some Text {
        BuiltinText(lines: content.lines)
    }
}
