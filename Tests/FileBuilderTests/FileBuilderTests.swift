
import FileBuilder
import XCTest

final class FileBuilderTests: XCTestCase {

    func test() throws {

        try AssertContent {
            TextFile {
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
        } is: {
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
        }
    }
}

struct Print: TextContent {
    let string: String
    init(_ string: String) {
        self.string = string
    }

    var body: some TextContent {
        #"print("\#(string)")"#
    }
}

struct Func<Content: TextContent>: TextContent {

    let name: String
    let content: Content
    init(_ name: String, @TextContentBuilder content: () -> Content) {
        self.name = name
        self.content = content()
    }

    var body: some TextContent {
        "func \(name)() {"
        content.indented()
        "}"
    }
}

struct If<True: TextContent, False: TextContent>: TextContent {

    let condition: String
    let trueContent: True
    let falseContent: False

    init(
        _ condition: String,
        @TextContentBuilder trueContent: () -> True,
        @TextContentBuilder else falseContent: () -> False
    ) {
        self.condition = condition
        self.trueContent = trueContent()
        self.falseContent = falseContent()
    }

    var body: some TextContent {
        "if \(condition) {"
        trueContent.indented()
        if False.self == NoContent.self {
            "}"
        } else {
            "} else {"
            falseContent.indented()
            "}"
        }
    }
}

extension If where False == NoContent {

    init(
        _ condition: String,
        @TextContentBuilder trueContent: () -> True
    ) {
        self.condition = condition
        self.trueContent = trueContent()
        self.falseContent = NoContent()
    }
}
