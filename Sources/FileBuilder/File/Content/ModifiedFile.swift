
extension Modified: File where Content: File, Modifier: FileModifier {

    public var file: some File {
        BuiltinFile { url, environment in
            let content = Modifier.Content(content: content)
            environment.install(on: modifier)
            try modifier
                .file(content: content)
                .write(in: url, environment: environment)
        }
    }
}
