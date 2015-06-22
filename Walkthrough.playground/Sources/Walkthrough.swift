import UIKit

public class Walkthrough : UIView, UIScrollViewDelegate {

    let scrollView : UIScrollView
    let numberOfPages : Int = 5
    let screenSize : CGSize
    let pageIndicator : UIPageControl

    public override init(frame: CGRect) {
        let bounds = CGRectMake(0, 0, frame.size.width, frame.size.height)
        scrollView = UIScrollView(frame: bounds)
        screenSize = frame.size
        pageIndicator = UIPageControl()

        super.init(frame: frame)
        scrollView.delegate = self
        self.addSubview(scrollView)
        pageIndicator.numberOfPages = self.numberOfPages
        pageIndicator.center = CGPointMake(CGRectGetMidX(bounds), bounds.size.height - 40)
        self.addSubview(pageIndicator)
        self.setupContentView()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContentView() {

        let contentView = UIView(frame: CGRectMake(0, 0, screenSize.width * CGFloat(numberOfPages), screenSize.height))
        contentView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSize(width: screenSize.width * CGFloat(numberOfPages), height: screenSize.height)
        scrollView.addSubview(contentView)

        let page1 = UIView(frame: self.bounds)
        page1.backgroundColor = UIColor.redColor()
        contentView.addSubview(page1)

        let page2 = UIView(frame: CGRectOffset(self.bounds, screenSize.width * 1, 0))
        page2.backgroundColor = UIColor.orangeColor()
        contentView.addSubview(page2)

        let page3 = UIView(frame: CGRectOffset(self.bounds, screenSize.width * 2, 0))
        page3.backgroundColor = UIColor.yellowColor()
        contentView.addSubview(page3)

        let page4 = UIView(frame: CGRectOffset(self.bounds, screenSize.width * 3, 0))
        page4.backgroundColor = UIColor.greenColor()
        contentView.addSubview(page4)

        let page5 = UIView(frame: CGRectOffset(self.bounds, screenSize.width * 4, 0))
        page5.backgroundColor = UIColor.blueColor()
        contentView.addSubview(page5)
    }

    public func animateScrollView(duration: NSTimeInterval = 2, delay: NSTimeInterval = 0.2) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.scrollView.contentOffset.x = self.bounds.size.width * CGFloat(self.numberOfPages - 1)
            }) { (success) -> Void in

        }
    }

    // MARK: UIScrollViewDelegate

    public func scrollViewDidScroll(scrollView: UIScrollView) {
        self.pageIndicator.currentPage = scrollView.page()
    }
}