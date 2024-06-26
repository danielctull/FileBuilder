
import Foundation

public struct Directory<Content: File>: File {

    private let name: FileName
    private let content: Content

    public init(
        _ name: FileName,
        @FileBuilder content: () -> Content
    ) {
        self.name = name
        self.content = content()
    }

    public var file: some File {
        BuiltinFile { directory, environment in
            let url = directory.appending(name)
            try FileManager().createDirectory(at: url, withIntermediateDirectories: true)
            try content.write(in: url, environment: environment)
        }
    }
}

extension Directory<Empty> {

    public init(_ name: FileName) {
        self.init(name) {
            Empty()
        }
    }
}
