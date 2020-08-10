#if os(macOS)

#else
import UIKit
#endif

public enum SegmentControlableItem {
    case title(String)
    case image(_UImage)
}
