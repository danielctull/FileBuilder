
import Foundation

extension File {

    public func directoryCreation(_ directoryCreation: DirectoryCreation) -> some File {
        environment(\.createDirectory, directoryCreation)
    }
}

public struct DirectoryCreation {

    public static let failIfExists = DirectoryCreation { url in
        try FileManager().createDirectory(at: url, withIntermediateDirectories: false)
    }

    public static let useExisting = DirectoryCreation { url in
        try FileManager().createDirectory(at: url, withIntermediateDirectories: true)
    }

    private let createDirectory: (URL) throws -> Void

    func callAsFunction(at url: URL) throws {
        try createDirectory(url)
    }
}

fileprivate enum CreateDirectoryKey: EnvironmentKey {
    static let defaultValue = DirectoryCreation.useExisting
}

extension EnvironmentValues {

    var createDirectory: DirectoryCreation {
        get { self[CreateDirectoryKey.self] }
        set { self[CreateDirectoryKey.self] = newValue }
    }
}
