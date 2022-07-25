
// MARK: - Content Modifier

extension Content {

    public func wrap(lineLength: Int) -> some Content {
        modifier(Wrap(length: lineLength))
    }
}

private struct Wrap<C: Content>: LineModifier {

    let length: Int

    func modifyLines(_ lines: [Line]) -> [Line] {
        lines.flatMap { line in
            line.rawValue
                .split(maximumLineLength: length)
                .map(String.init)
                .map(Line.init)
        }
    }
}

extension StringProtocol {

    fileprivate func split(maximumLineLength: Int) -> [SubSequence] {

        guard count > maximumLineLength else {
            return [self[startIndex..<endIndex]]
        }

        let head: SubSequence
        let tail: SubSequence
        if let space = dropLast(count - maximumLineLength).lastIndex(of: " ") {
            head = self[..<space]
            tail = self[index(after: space)...]
        } else {
            let end = index(startIndex, offsetBy: maximumLineLength)
            head = self[..<end]
            tail = self[end...]
        }

        return [head] + tail.split(maximumLineLength: maximumLineLength)
    }
}
