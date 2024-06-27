
@resultBuilder
public enum TextBuilder {

    public static func buildPartialBlock<Content: Text>(
        first: Content
    ) -> Content {
        first
    }

    public static func buildPartialBlock<First: Text, Second: Text>(
        accumulated: First,
        next: Second
    ) -> Accumulated<First, Second> {
        Accumulated(first: accumulated, second: next)
    }

    public static func buildArray<Content: Text>(
        _ array: Array<Content>
    ) -> Array<Content> {
        array
    }

    public static func buildEither<First: Text, Second: Text>(
        first: First
    ) -> Either<First, Second> {
        Either(first)
    }

    public static func buildEither<First: Text, Second: Text>(
        second: Second
    ) -> Either<First, Second> {
        Either(second)
    }

    public static func buildLimitedAvailability<Content: Text>(
        _ content: Content
    ) -> Content {
        content
    }

    public static func buildOptional<Content: Text>(
        _ optional: Optional<Content>
    ) -> Optional<Content> {
        optional
    }

    public static func buildFinalResult<Content: Text>(
        _ component: Content
    ) -> Content {
        component
    }

    public static func buildBlock() -> Empty {
        Empty()
    }
}
