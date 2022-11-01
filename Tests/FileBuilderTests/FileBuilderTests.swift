
import FileBuilder
import XCTest

final class FileBuilderTests: XCTestCase {

    func test() throws {

        try AssertContent {
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
