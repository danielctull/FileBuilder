
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

    public static func buildEither<True: File, False: File>(
        first: True
    ) -> Conditional<True, False> {
        Conditional(first)
    }

    public static func buildEither<True: File, False: File>(
        second: False
    ) -> Conditional<True, False> {
        Conditional(second)
    }

    public static func buildLimitedAvailability<Content: File>(
        _ content: Content
    ) -> AnyFile {
        AnyFile(content)
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
}
