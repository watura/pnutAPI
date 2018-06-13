import UIKit
import Utils

public class StreamViewController: UIViewController {}

extension StreamViewController: InitableType {
    public typealias VC = StreamViewController
    public static var storyboardName: String { return "Stream" }
    public static var identifier: String { return "StreamView" }
}
