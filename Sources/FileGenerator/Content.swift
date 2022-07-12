
import Foundation

public struct Content: Equatable {

    private enum Kind: Equatable {
        case line(Line)
        case section(Section)
    }

    private let kind: Kind
}

extension Content {
    public static func line(_ line: Line) -> Self { Self(kind: .line(line)) }
    public static func section(_ section: Section) -> Self { Self(kind: .section(section)) }
}

// MARK: - Builder

@resultBuilder
public enum ContentBuilder {

    public static func buildExpression(_ line: Line) -> Content { .line(line) }
    public static func buildExpression(_ section: Section) -> Content { .section(section) }

    public static func buildPartialBlock(first: Content) -> [Content] {
        [first]
    }

    public static func buildPartialBlock(accumulated: [Content], next: Content) -> [Content] {
        accumulated + [next]
    }

    public static func buildFinalResult(_ component: [Content]) -> [Content] {
        component
    }
}
