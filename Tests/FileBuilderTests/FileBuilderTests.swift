
import FileBuilder
import XCTest

final class FileBuilderTests: XCTestCase {

    func testFirst() throws {
        try AssertFile {
            TextFile("Test") {
                "Hi"
            }
        } outputs: {
            .file(name: "Test", text: "Hi")
        }
    }

    func testAccumulation() throws {
        try AssertFile {
            Directory("Directory") {
                TextFile("File 1") { "One" }
                TextFile("File 2") { "Two" }
            }
        } outputs: {
            .directory(name: "Directory", items: [
                .file(name: "File 1", text: "One"),
                .file(name: "File 2", text: "Two"),
            ])
        }
    }

    func testArray() throws {
        try AssertFile {
            Directory("Directory") {
                for i in 1...3 {
                    TextFile("File \(i)") { "Value \(i)" }
                }
            }
        } outputs: {
            .directory(name: "Directory", items: [
                .file(name: "File 1", text: "Value 1"),
                .file(name: "File 2", text: "Value 2"),
                .file(name: "File 3", text: "Value 3"),
            ])
        }
    }

    func testEither() throws {

        @FileBuilder
        func content(_ bool: Bool) -> some File {
            if bool {
                TextFile("True") { "True Content" }
            } else {
                TextFile("False") { "False Content" }
            }
        }

        try AssertFile {
            content(true)
        } outputs: {
            .file(name: "True", text: "True Content")
        }

        try AssertFile {
            content(false)
        } outputs: {
            .file(name: "False", text: "False Content")
        }
    }

#if !os(Linux)
    // I can't find an #available flag that exists for linux machines.
    func testLimitedAvailability() throws {

        try AssertFile {
            if #available(macOS 9999, *) {
                TextFile("Future") {
                    "Future Content"
                }
            } else if #available(*) { // <-- This causes the builder to hit
                TextFile("Current") { //     buildLimitedAvailability.
                    "Current Content"
                }
            }
        } outputs: {
            .file(name: "Current", text: "Current Content")
        }
    }
#endif

    func testOptional() throws {

        @FileBuilder
        func content(_ bool: Bool) -> some File {
            if bool {
                TextFile("True") { "True Content" }
            }
        }

        try AssertFile {
            content(true)
        } outputs: {
            .file(name: "True", text: "True Content")
        }

        try AssertFile {
            content(false)
        } outputs: {
            []
        }
    }

    func test() throws {

        try AssertFile {
            TextFile("Test") {
                Func("foo") {
                    If("value == 4") {
                        Print("It's 4!")
                    }
                    If("value == 2") {
                        Print("It's 2!")
                    } else: {
                        Print("It's not 2!")
                    }
                }
            }
            .indentation(.spaces(2))
        } outputs: {
            .file(name: "Test", text:
                """
                func foo() {
                  if value == 4 {
                    print("It's 4!")
                  }
                  if value == 2 {
                    print("It's 2!")
                  } else {
                    print("It's not 2!")
                  }
                }
                """
            )
        }
    }
}

struct Print: Text {
    let string: String
    init(_ string: String) {
        self.string = string
    }

    var body: some Text {
        #"print("\#(string)")"#
    }
}

struct Func<Content: Text>: Text {

    let name: String
    let content: Content
    init(_ name: String, @TextBuilder content: () -> Content) {
        self.name = name
        self.content = content()
    }

    var body: some Text {
        "func \(name)() {"
        content.indented()
        "}"
    }
}

struct If<True: Text, False: Text>: Text {

    let condition: String
    let trueContent: True
    let falseContent: False

    init(
        _ condition: String,
        @TextBuilder trueContent: () -> True,
        @TextBuilder else falseContent: () -> False
    ) {
        self.condition = condition
        self.trueContent = trueContent()
        self.falseContent = falseContent()
    }

    var body: some Text {
        "if \(condition) {"
        trueContent.indented()
        if False.self == EmptyText.self {
            "}"
        } else {
            "} else {"
            falseContent.indented()
            "}"
        }
    }
}

extension If where False == EmptyText {

    init(
        _ condition: String,
        @TextBuilder trueContent: () -> True
    ) {
        self.condition = condition
        self.trueContent = trueContent()
        self.falseContent = EmptyText()
    }
}
