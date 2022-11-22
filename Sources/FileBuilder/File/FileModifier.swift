
extension File {

    public func modifier<Modifier: FileModifier>(
        _ modifier: Modifier
    ) -> Modified<Self, Modifier> {
        Modified(content: self, modifier: modifier)
    }
}

extension Modified: File where Content: File, Modifier: FileModifier {

    public var file: some File {
        BuiltinFile { environment in
            let content = Modifier.Content(content: content)
            environment.install(on: modifier)
            return try modifier
                .file(content: content)
                .fileWrappers(environment: environment)
        }
    }
}

// MARK: - FileModifier

public protocol FileModifier {

    typealias Content = _FileModifier_Content
    associatedtype SomeFile: File

    @FileBuilder
    func file(content: Content) -> SomeFile
}

public struct _FileModifier_Content: File {
    let content: any File
    public var file: some File {
        BuiltinFile(fileWrappers: content.fileWrappers)
    }
}
