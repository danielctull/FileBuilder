
extension Modified: File where Content: File, Modifier: FileModifier, Content == Modifier.Content {

    public var body: some File {
        BuiltinFile { url, environment in
            environment.install(on: modifier)
            try modifier
                .body(content: content)
                .write(in: url, environment: environment)
        }
    }
}
