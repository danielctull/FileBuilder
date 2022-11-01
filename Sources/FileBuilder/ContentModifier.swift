
public protocol ContentModifier {
    associatedtype Content
    associatedtype Body: Text

    @TextBuilder
    func body(content: Content) -> Body
}

extension Text {

    public func modifier<Modifier: ContentModifier>(
        _ modifier: Modifier
    ) -> ModifiedContent<Self, Modifier> where Modifier.Content == Self {
        ModifiedContent(content: self, modifier: modifier)
    }
}

public struct ModifiedContent<Content, Modifier> {
    fileprivate let content: Content
    fileprivate let modifier: Modifier
}

extension ModifiedContent: Text where Content: Text, Modifier: ContentModifier, Content == Modifier.Content {

    public var body: some Text {
        BuiltinContent { environment in
            environment.install(on: modifier)
            return modifier
                .body(content: content)
                .generate(environment: environment)
        }
    }
}
