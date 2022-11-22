
import Foundation

public struct TextFile<Content: Text>: File {

    @Environment(\.stringEncoding) private var encoding: String.Encoding
    private let name: String
    private let text: Content

    public init(
        _ name: String,
        @TextBuilder text: () -> Content
    ) {
        self.name = name
        self.text = text()
    }

    public var file: some File {
        BuiltinFile { environment in
            let string = String(text, environment: environment)
            guard let data = string.data(using: encoding) else {
                throw TextFileFailure(name: name)
            }
            return [name: FileWrapper(regularFileWithContents: data)]
        }
    }
}

struct TextFileFailure: Error {
    let name: String
}
