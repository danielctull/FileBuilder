
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

extension ModifiedContent: Text where Content: Text, Modifier: TextModifier, Content == Modifier.Content {

    public var body: some Text {
        BuiltinContent { environment in
            environment.install(on: modifier)
            return modifier
                .body(content: content)
                .generate(environment: environment)
        }
    }
}
