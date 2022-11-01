
import Foundation

public struct Directory<Content: File> {

    private let name: String
    private let content: Content

    public init(
        _ name: String,
        @FileBuilder content: () -> Content
    ) {
        self.name = name
        self.content = content()
    }
}

// MARK: - File

extension Directory: File {

    public var body: some File {
        BuiltinFile { directory, environment in
            let url = directory.appendingPathComponent(name)
            try FileManager().createDirectory(at: url, withIntermediateDirectories: false)
            try content.write(in: url, environment: environment)
        }
    }
}
