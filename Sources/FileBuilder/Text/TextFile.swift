
import Foundation

public struct TextFile<Content: Text>: Text {

    private let encoding: String.Encoding
    private let content: Content

    public init(
        encoding: String.Encoding = .utf8,
        @TextBuilder content: () -> Content
    ) {
        self.encoding = encoding
        self.content = content()
    }

    public var body: some Text {
        content
    }
}

// MARK: - File

struct TextFailure: Error {}

extension TextFile: File {

    public var data: Data {
        get throws {
            guard let data = content.data(using: encoding) else {
                throw TextFailure()
            }
            return data
        }
    }
}
