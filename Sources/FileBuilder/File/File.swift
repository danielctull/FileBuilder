
import Foundation

public protocol File {
    var name: String { get }
    func write(in directory: URL) throws
}
