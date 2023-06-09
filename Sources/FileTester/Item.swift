
import Foundation

public struct Item {

    let kind: Kind

    enum Kind {
        case directory(name: String, items: [Item])
        case fileExists(name: String)
        case dataFile(name: String, data: Data)
        case textFile(name: String, text: String, encoding: String.Encoding)
    }
}

extension Item {

    public static func directory(name: String) -> Self {
        Item(kind: .directory(name: name, items: []))
    }

    public static func directory(name: String, items: [Item]) -> Self {
        Item(kind: .directory(name: name, items: items))
    }

    /// Checks that the file exists on disk.
    ///
    /// This doesn't check the contents of the file, merely that it exists.
    ///
    /// - Parameter name: The name of the file
    /// - Returns: An item representing a file exists check.
    public static func file(name: String) -> Self {
        Item(kind: .fileExists(name: name))
    }

    public static func file(name: String, data: Data) -> Self {
        Item(kind: .dataFile(name: name, data: data))
    }

    public static func file(name: String, text: String, encoding: String.Encoding = .utf8) -> Self {
        Item(kind: .textFile(name: name, text: text, encoding: encoding))
    }
}
