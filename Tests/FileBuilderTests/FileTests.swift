
import FileBuilder
import XCTest

final class FileTests: XCTestCase {

    func testWrite() throws {
        try FileManager().withTemporaryDirectory { url in
            let one = UUID().uuidString
            let two = UUID().uuidString
            let three = UUID().uuidString
            let file = File {
                one
                two
                three
            }
            let url = url.appendingPathComponent(UUID().uuidString)
            try file.write(to: url, atomically: true, encoding: .utf8)
            let result = try String(contentsOf: url)
            XCTAssertEqual(result, "\(one)\n\(two)\n\(three)")
        }
    }
}

extension FileManager {

    func withTemporaryDirectory(_ perform: (URL) throws -> Void) throws {
        let url = temporaryDirectory
            .appendingPathComponent("FileBuilderTests")
            .appendingPathComponent(UUID().uuidString)
        try createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
        try perform(url)
        try removeItem(at: url)
    }
}
