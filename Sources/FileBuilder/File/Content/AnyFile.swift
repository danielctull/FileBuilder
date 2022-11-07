
import Foundation

public struct AnyFile: File {

    private let write: (URL, EnvironmentValues) throws -> Void

    public init<Content: File>(_ content: Content) {
        write = content.write(in:environment:)
    }

    public var body: some File {
        BuiltinFile(write: write)
    }
}
