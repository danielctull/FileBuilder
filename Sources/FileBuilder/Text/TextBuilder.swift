
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
        _ array: [Content]
    ) -> [Content] {
        array
    }

    public static func buildEither<True: Text, False: Text>(
        first: True
    ) -> Conditional<True, False> {
        Conditional(first)
    }

    public static func buildEither<True: Text, False: Text>(
        second: False
    ) -> Conditional<True, False> {
        Conditional(second)
    }

    public static func buildLimitedAvailability<Content: Text>(
        _ content: Content
    ) -> AnyText {
        AnyText(content)
    }

    public static func buildOptional<Content: Text>(
        _ optional: Content?
    ) -> Content? {
        optional
    }
    public static func buildFinalResult<Content: Text>(
        _ component: Content
    ) -> Content {
        component
    }
}
