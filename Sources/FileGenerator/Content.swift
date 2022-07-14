
public protocol Content {
    associatedtype Body: Content
    var body: Body { get }
}

// MARK: - Generator

extension Content {

    func generate(indentation: Indentation) -> [Line] {

        if let builtin = self as? Builtin {
            return builtin.generate(indentation: indentation)
        }

        return body.generate(indentation: indentation)
    }
}

// MARK: - Builder

@resultBuilder
public enum ContentBuilder {

//    public static func buildPartialBlock(first: some Content) -> some Content {
//        first
//    }
//
//    public static func buildPartialBlock(accumulated: some Content, next: some Content) -> some Content {
//        AccumulatedContent(first: accumulated, second: next)
//    }

    public static func buildBlock<C0: Content>(_ c0: C0) -> some Content {
        c0
    }

    public static func buildBlock<C0: Content, C1: Content>(_ c0: C0, _ c1: C1) -> some Content {
        AccumulatedContent(first: c0, second: c1)
    }

    public static func buildBlock<C0: Content, C1: Content, C2: Content>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2
    ) -> some Content {
        let a0 = AccumulatedContent(first: c0, second: c1)
        let a1 = AccumulatedContent(first: a0, second: c2)
        return a1
    }

    public static func buildBlock<C0: Content, C1: Content, C2: Content, C3: Content>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3
    ) -> some Content {
        let a0 = AccumulatedContent(first: c0, second: c1)
        let a1 = AccumulatedContent(first: a0, second: c2)
        let a2 = AccumulatedContent(first: a1, second: c3)
        return a2
    }

    public static func buildBlock<C0: Content, C1: Content, C2: Content, C3: Content, C4: Content>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
        _ c4: C4
    ) -> some Content {
        let a0 = AccumulatedContent(first: c0, second: c1)
        let a1 = AccumulatedContent(first: a0, second: c2)
        let a2 = AccumulatedContent(first: a1, second: c3)
        let a3 = AccumulatedContent(first: a2, second: c4)
        return a3
    }

    public static func buildBlock<C0: Content, C1: Content, C2: Content, C3: Content, C4: Content, C5: Content>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
        _ c4: C4,
        _ c5: C5
    ) -> some Content {
        let a0 = AccumulatedContent(first: c0, second: c1)
        let a1 = AccumulatedContent(first: a0, second: c2)
        let a2 = AccumulatedContent(first: a1, second: c3)
        let a3 = AccumulatedContent(first: a2, second: c4)
        let a4 = AccumulatedContent(first: a3, second: c5)
        return a4
    }

    public static func buildBlock<C0: Content, C1: Content, C2: Content, C3: Content, C4: Content, C5: Content, C6: Content>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
        _ c4: C4,
        _ c5: C5,
        _ c6: C6
    ) -> some Content {
        let a0 = AccumulatedContent(first: c0, second: c1)
        let a1 = AccumulatedContent(first: a0, second: c2)
        let a2 = AccumulatedContent(first: a1, second: c3)
        let a3 = AccumulatedContent(first: a2, second: c4)
        let a4 = AccumulatedContent(first: a3, second: c5)
        let a5 = AccumulatedContent(first: a4, second: c6)
        return a5
    }

    public static func buildBlock<C0: Content, C1: Content, C2: Content, C3: Content, C4: Content, C5: Content, C6: Content, C7: Content>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
        _ c4: C4,
        _ c5: C5,
        _ c6: C6,
        _ c7: C7
    ) -> some Content {
        let a0 = AccumulatedContent(first: c0, second: c1)
        let a1 = AccumulatedContent(first: a0, second: c2)
        let a2 = AccumulatedContent(first: a1, second: c3)
        let a3 = AccumulatedContent(first: a2, second: c4)
        let a4 = AccumulatedContent(first: a3, second: c5)
        let a5 = AccumulatedContent(first: a4, second: c6)
        let a6 = AccumulatedContent(first: a5, second: c7)
        return a6
    }

    public static func buildArray<C: Content>(_ array: [C]) -> [C] {
        array
    }

    public static func buildEither<C: Content>(first: C) -> C {
        first
    }

    public static func buildEither<C: Content>(second: C) -> C {
        second
    }

    public static func buildOptional<C: Content>(_ optional: C?) -> C? {
        optional
    }

    public static func buildFinalResult(_ component: some Content) -> some Content {
        component
    }
}
