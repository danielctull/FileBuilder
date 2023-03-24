
extension Modified: Text where Content: Text, Modifier: TextModifier {

    public var body: some Text {
        BuiltinText { environment in
            let content = Modifier.Content(content: content)
            environment.install(on: modifier)
            return modifier
                .body(content: content)
                .lines(environment: environment)
        }
    }
}
