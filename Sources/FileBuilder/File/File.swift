
import Foundation

public protocol File {
    var name: String { get }
    var data: Data { get throws }
}
