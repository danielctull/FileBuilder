
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
