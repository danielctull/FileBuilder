
extension String: Content {

    public var body: some Content {
        Line(rawValue: self)
    }
}
