
public protocol TextModifier {
    associatedtype Content
    associatedtype Body: Text

    @TextBuilder
    func body(content: Content) -> Body
}

extension Text {

    public func modifier<Modifier: TextModifier>(
        _ modifier: Modifier
    ) -> Modified<Self, Modifier> where Modifier.Content == Self {
        Modified(content: self, modifier: modifier)
    }
}
