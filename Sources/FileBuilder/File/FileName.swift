import Foundation

public struct FileName: Equatable, Hashable {
    fileprivate let value: String
    public init(_ value: String) {
        self.value = value
    }
}

extension FileName: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension FileName: ExpressibleByStringInterpolation {}

extension FileName: CustomStringConvertible {
    public var description: String { value }
}

extension FileName: CustomDebugStringConvertible {
    public var debugDescription: String { value }
}

extension URL {
    func appending(_ name: FileName) -> URL {
        appendingPathComponent(name.value)
    }
}
