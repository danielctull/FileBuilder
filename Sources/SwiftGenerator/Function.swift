
import FileGenerator

public struct Function: Content {

    let name: String

    public init(name: String) {
        self.name = name
    }

    @ContentBuilder
    public var body: some Content {
        Line("func \(name)() {")
    }
}
