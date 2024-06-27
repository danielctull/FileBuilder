
@resultBuilder
public enum FileBuilder {

    public static func buildPartialBlock<Content: File>(
        first: Content
    ) -> Content {
        first
    }

    public static func buildPartialBlock<First: File, Second: File>(
        accumulated: First,
        next: Second
    ) -> Accumulated<First, Second> {
        Accumulated(first: accumulated, second: next)
    }

    public static func buildArray<Content: File>(
        _ array: Array<Content>
    ) -> Array<Content> {
        array
    }

    public static func buildEither<First: File, Second: File>(
        first: First
    ) -> Either<First, Second> {
        Either(first)
    }

    public static func buildEither<First: File, Second: File>(
        second: Second
    ) -> Either<First, Second> {
        Either(second)
    }

    public static func buildLimitedAvailability<Content: File>(
        _ content: Content
    ) -> Content {
        content
    }

    public static func buildOptional<Content: File>(
        _ optional: Optional<Content>
    ) -> Optional<Content> {
        optional
    }

    public static func buildFinalResult<Content: File>(
        _ component: Content
    ) -> Content {
        component
    }

    public static func buildBlock() -> Empty {
        Empty()
    }
}
