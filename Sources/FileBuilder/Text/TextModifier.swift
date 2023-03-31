
extension Text {

    public func modifier<Modifier: TextModifier>(
        _ modifier: Modifier
    ) -> Modified<Self, Modifier> {
        Modified(content: self, modifier: modifier)
    }
}

// MARK: - TextModifier

public protocol TextModifier {
    typealias Content = _TextModifier_Content
    associatedtype SomeText: Text

    @TextBuilder
    func text(content: Content) -> SomeText
}

public struct _TextModifier_Content: Text {
    let content: any Text
    public var text: some Text {
        BuiltinText(lines: content.lines)
    }
}

// MARK: - LinesModifier

public protocol LinesModifier: TextModifier {
    func lines(content: [Line]) -> [Line]
}

extension LinesModifier {

    public func text(content: Content) -> some Text {
        BuiltinText { environment in
            let content = content.lines(environment: environment)
            return lines(content: content)
        }
    }
}

// MARK: - LineModifier

public protocol LineModifier: LinesModifier {
    func line(content: Line) -> Line
}

extension LineModifier {

    public func lines(content: [Line]) -> [Line] {
        content.map(line(content:))
    }
}
