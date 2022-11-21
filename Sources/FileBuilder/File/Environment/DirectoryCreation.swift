
import Foundation

extension File {

    public func directoryCreation(_ directoryCreation: DirectoryCreation) -> some File {
        environment(\.createDirectory, directoryCreation)
    }
}

public struct DirectoryCreation {

    public static let `default` = DirectoryCreation { url in
        try FileManager().createDirectory(at: url, withIntermediateDirectories: false)
    }

    public static let useExisting = DirectoryCreation { url in
        let fm = FileManager()
        guard !fm.directoryExists(at: url) else { return }
        try fm.createDirectory(at: url, withIntermediateDirectories: false)
    }

    private let createDirectory: (URL) throws -> Void

    func callAsFunction(at url: URL) throws {
        try createDirectory(url)
    }
}

extension FileManager {

    func directoryExists(at url: URL) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = fileExists(atPath: url.path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}

fileprivate enum CreateDirectoryKey: EnvironmentKey {
    static let defaultValue = DirectoryCreation.default
}

extension EnvironmentValues {

    var createDirectory: DirectoryCreation {
        get { self[CreateDirectoryKey.self] }
        set { self[CreateDirectoryKey.self] = newValue }
    }
}
