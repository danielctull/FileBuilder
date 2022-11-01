
public protocol TextModifier {
    associatedtype Content
    associatedtype Body: Text

    @TextBuilder
    func body(content: Content) -> Body
}

extension Text {

    public func modifier<Modifier: TextModifier>(
        _ modifier: Modifier
    ) -> ModifiedContent<Self, Modifier> where Modifier.Content == Self {
        ModifiedContent(content: self, modifier: modifier)
    }
}
