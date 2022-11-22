
import Foundation

public struct Directory<Content: File>: File {

    private let name: String
    private let content: Content

    public init(
        _ name: String,
        @FileBuilder content: () -> Content
    ) {
        self.name = name
        self.content = content()
    }

    public var file: some File {
        BuiltinFile { environment in
            try [name: FileWrapper(directoryWithFileWrappers: content.fileWrappers(environment: environment))]
        }
    }
}
