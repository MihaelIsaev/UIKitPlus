extension String: SegmentControlable {
    public var item: SegmentControlableItem { .title(self) }
}
