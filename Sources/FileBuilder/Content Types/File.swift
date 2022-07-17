
import Foundation

public struct File<C: Content>: Content {

    private let content: C

    public init(@ContentBuilder content: () -> C) {
        self.content = content()
    }

    public var body: some Content {
        content
    }
}

extension File {

    public func write(
        to url: URL,
        atomically: Bool,
        encoding: String.Encoding
    ) throws {
        try content.write(to: url, atomically: atomically, encoding: encoding)
    }
}
