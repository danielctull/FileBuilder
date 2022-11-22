
public struct AnyFile: File {

    private let content: any File

    public init(_ content: some File) {
        self.content = content
    }

    public var file: some File {
        BuiltinFile(fileWrappers: content.fileWrappers)
    }
}
