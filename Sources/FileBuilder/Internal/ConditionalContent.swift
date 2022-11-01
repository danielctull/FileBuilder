
public struct ConditionalContent<True, False> {

    enum Value {
        case `true`(True)
        case `false`(False)
    }

    let value: Value

    init(_ content: True) {
        value = .true(content)
    }

    init(_ content: False) {
        value = .false(content)
    }
}
