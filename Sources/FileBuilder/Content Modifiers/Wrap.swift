
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
                .map(Line.init)
        }
    }
}

extension String {

    fileprivate func split(maximumLineLength: Int) -> [String] {

        guard count > maximumLineLength else { return [self] }

        let head: Substring
        let tail: Substring
        if let space = dropLast(count - maximumLineLength).lastIndex(of: " ") {
            head = self[..<space]
            tail = self[index(after: space)...]
        } else {
            let end = index(startIndex, offsetBy: maximumLineLength)
            head = self[..<end]
            tail = self[end...]
        }

        return [String(head)]
            +
            String(tail).split(maximumLineLength: maximumLineLength)
    }
}
