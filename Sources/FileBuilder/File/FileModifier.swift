
public protocol FileModifier {

    typealias Content = _FileModifier_Content
    associatedtype Body: File

    @FileBuilder
    func body(content: Content) -> Body
}

extension File {

    public func modifier<Modifier: FileModifier>(
        _ modifier: Modifier
    ) -> Modified<Self, Modifier> {
        Modified(content: self, modifier: modifier)
    }
}

public struct _FileModifier_Content: File {
    let content: any File
    public var file: some File {
        BuiltinFile(write: content.write)
    }
}
