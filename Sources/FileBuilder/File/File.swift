
import Foundation

public protocol File {
    func write(in directory: URL) throws
}
