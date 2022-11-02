
extension Modified: Text where Content: Text, Modifier: TextModifier, Content == Modifier.Content {

    public var body: some Text {
        BuiltinText { environment in
            environment.install(on: modifier)
            return modifier
                .body(content: content)
                .generate(environment: environment)
        }
    }
}
