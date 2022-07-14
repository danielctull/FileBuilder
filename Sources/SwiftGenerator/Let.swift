
import FileGenerator

struct Let: Content {
    let name: String


    var body: some Content {
        "let \(name)"
    }
}
