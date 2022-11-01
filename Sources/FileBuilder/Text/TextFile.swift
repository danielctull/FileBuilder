
import Foundation

public struct TextFile<Content: Text>: Text {

    public let name: String
    private let encoding: String.Encoding
    private let content: Content

    public init(
        _ name: String,
        encoding: String.Encoding = .utf8,
        @TextBuilder content: () -> Content
    ) {
        self.name = name
        self.encoding = encoding
        self.content = content()
    }

    public var body: some Text {
        content
    }
}

// MARK: - File

struct TextFileFailure: Error {
    let name: String
}

extension TextFile: File {

    public var data: Data {
        get throws {
            guard let data = content.data(using: encoding) else {
                throw TextFileFailure(name: name)
            }
            return data
        }
    }
}
