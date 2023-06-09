
import FileBuilder
import FileTester
import XCTest

final class IndentationTests: XCTestCase {

    func testNone() throws {
        try AssertText {
            "One".indentation(.tab)
            "Two".indentation(.spaces(1))
            "Three".indentation(.spaces(8))
        } is: {
            """
            One
            Two
            Three
            """
        }
    }

    func testDefault() throws {
        try AssertText {
            "One".indent()
        } is: {
            "    One"
        }
    }

    func testTab() throws {
        try AssertText {
            "One".indent().indentation(.tab)
        } is: {
            "\tOne"
        }
    }

    func testSpaces1() throws {
        try AssertText {
            "One".indent().indentation(.spaces(1))
        } is: {
            " One"
        }
    }

    func testSpaces8() throws {
        try AssertText {
            "One".indent().indentation(.spaces(8))
        } is: {
            "        One"
        }
    }

    func testFile() throws {
        try AssertFile {
            TextFile("Test") {
                "One".indent()
            }
            .indentation(.spaces(6))
        } outputs: {
            .file(name: "Test", text: "      One")
        }
    }
}
