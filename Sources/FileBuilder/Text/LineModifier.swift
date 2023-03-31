
public protocol LineModifier: LinesModifier {
    func line(content: Line) -> Line
}

extension LineModifier {

    public func lines(content: [Line]) -> [Line] {
        content.map(line(content:))
    }
}
