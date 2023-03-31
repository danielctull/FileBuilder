
extension Modified: Text where Content: Text, Modifier: TextModifier {

    public var text: some Text {
        BuiltinText { environment in
            let content = Modifier.Content(content: content)
            environment.install(on: modifier)
            return modifier
                .text(content: content)
                .lines(environment: environment)
        }
    }
}
