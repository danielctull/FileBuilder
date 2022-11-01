
@resultBuilder
public enum ContentBuilder {

    public static func buildPartialBlock<Content: TextContent>(
        first: Content
    ) -> Content {
        first
    }

    public static func buildPartialBlock<Accumulated: TextContent, Next: TextContent>(
        accumulated: Accumulated,
        next: Next
    ) -> AccumulatedContent<Accumulated, Next> {
        AccumulatedContent(first: accumulated, second: next)
    }

    public static func buildArray<Content: TextContent>(
        _ array: [Content]
    ) -> [Content] {
        array
    }

    public static func buildEither<True: TextContent, False: TextContent>(
        first: True
    ) -> ConditionalContent<True, False> {
        ConditionalContent(first)
    }

    public static func buildEither<True: TextContent, False: TextContent>(
        second: False
    ) -> ConditionalContent<True, False> {
        ConditionalContent(second)
    }

    public static func buildLimitedAvailability<Content: TextContent>(
        _ content: Content
    ) -> AnyTextContent {
        AnyTextContent(content)
    }

    public static func buildOptional<Content: TextContent>(
        _ optional: Content?
    ) -> Content? {
        optional
    }
    public static func buildFinalResult<Content: TextContent>(
        _ component: Content
    ) -> Content {
        component
    }
}
