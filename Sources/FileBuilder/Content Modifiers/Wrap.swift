
// MARK: - Content Modifier

extension Content {

    public func wrap(lineLength: Int) -> some Content {
        modifier(Wrap(lineLength: lineLength))
    }
}

private struct Wrap<C: Content>: LineModifier {

    let lineLength: Int

    func modifyLines(_ lines: [Line]) -> [Line] {
        lines.flatMap { line in
            line.rawValue
                .lines(ofLength: lineLength)
                .map(String.init)
                .map(Line.init)
        }
    }
}

extension StringProtocol {

    fileprivate func lines(ofLength lineLength: Int) -> [SubSequence] {

        guard count > lineLength else {
            return [self[startIndex..<endIndex]]
        }

        let head: SubSequence
        let tail: SubSequence
        if let space = dropLast(count - lineLength).lastIndex(of: " ") {
            head = self[..<space]
            tail = self[index(after: space)...]
        } else {
            let end = index(startIndex, offsetBy: lineLength)
            head = self[..<end]
            tail = self[end...]
        }

        return [head] + tail.lines(ofLength: lineLength)
    }
}
