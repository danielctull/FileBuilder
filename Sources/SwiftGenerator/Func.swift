
import FileGenerator

public struct Func<C: Content>: Content {

    let name: String
    let content: C

    public init(name: String, @ContentBuilder content: () -> C) {
        self.name = name
        self.content = content()
    }

    @ContentBuilder
    public var body: some Content {
        "func \(name)() {"
        content.indented()
        "}"
    }
}
