import UIKit

public extension UIScrollView {
    public func page() -> Int {
        let scrollView = self
        let page = Int(roundf(Float(scrollView.contentOffset.x / scrollView.frame.size.width)))
        return page
    }
}