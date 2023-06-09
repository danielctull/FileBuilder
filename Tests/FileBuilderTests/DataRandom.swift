
import Foundation

extension Data {

    static func random(length: Int = 20) -> Data {
        let bits = (0..<length)
            .map { _ in UInt8.random(in: UInt8.min...UInt8.max) }
        return Data(bits)
    }
}
