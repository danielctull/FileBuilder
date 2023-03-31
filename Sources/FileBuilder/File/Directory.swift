
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
        BuiltinFile { directory, environment in
            let url = directory.appendingPathComponent(name)
            try FileManager().createDirectory(at: url, withIntermediateDirectories: true)
            try content.write(in: url, environment: environment)
        }
    }
}
