
public protocol FileModifier {
    associatedtype Content
    associatedtype Body: File

    @FileBuilder
    func body(content: Content) -> Body
}

extension File {

    public func modifier<Modifier: FileModifier>(
        _ modifier: Modifier
    ) -> Modified<Self, Modifier> where Modifier.Content == Self {
        Modified(content: self, modifier: modifier)
    }
}
