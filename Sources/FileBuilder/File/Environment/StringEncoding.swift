
extension File {

    public func stringEncoding(_ encoding: String.Encoding) -> some File {
        environment(\.stringEncoding, encoding)
    }
}

// MARK: - Environment

enum StringEncodingKey: EnvironmentKey {
    static let defaultValue = String.Encoding.utf8
}

extension EnvironmentValues {

    var stringEncoding: String.Encoding {
        get { self[StringEncodingKey.self] }
        set { self[StringEncodingKey.self] = newValue }
    }
}
