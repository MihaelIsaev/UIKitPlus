extension String: SegmentControlable {
    public var item: SegmentControlableItem { return .title(self) }
}
