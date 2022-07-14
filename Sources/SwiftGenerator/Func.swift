
import FileGenerator

public struct Func<C: Content>: Content {

    let access: AccessLevel
    let name: String
    let content: C

    public init(
        _ access: AccessLevel = .none,
        name: String,
        @ContentBuilder content: () -> C
    ) {
        self.access = access
        self.name = name
        self.content = content()
    }

    public var body: some Content {
        "\(access)func \(name)() {"
        content.indented()
        "}"
    }
}
