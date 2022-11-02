
import Foundation

public struct TextFile<Content: Text>: File {

    private let name: String
    private let encoding: String.Encoding
    private let text: Content

    public init(
        _ name: String,
        encoding: String.Encoding = .utf8,
        @TextBuilder text: () -> Content
    ) {
        self.name = name
        self.encoding = encoding
        self.text = text()
    }

    public var body: some File {
        BuiltinFile { directory, environment in
            let string = text.content(environment: environment)
            guard let data = string.data(using: encoding) else {
                throw TextFileFailure(name: name)
            }
            let url = directory.appendingPathComponent(name)
            try data.write(to: url)
        }
    }
}

struct TextFileFailure: Error {
    let name: String
}
