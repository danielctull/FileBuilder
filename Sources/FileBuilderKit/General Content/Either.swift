
public struct Either<First, Second> {

    enum Value {
        case first(First)
        case second(Second)
    }

    let value: Value

    init(_ first: First) {
        value = .first(first)
    }

    init(_ second: Second) {
        value = .second(second)
    }
}
