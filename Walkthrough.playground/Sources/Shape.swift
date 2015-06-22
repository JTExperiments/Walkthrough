import UIKit

public protocol Shape {
    var rect : CGRect { get }
    var strokeColor : UIColor? { get }
    var fillColor : UIColor? { get }
    var path : CGPath? { get }
}

public struct Oval : Shape {
    public let rect : CGRect
    public var strokeColor : UIColor?
    public var fillColor : UIColor?
    public var path : CGPath? {
        return CGPathCreateWithEllipseInRect(self.rect, nil)
    }
    public init(rect: CGRect, strokeColor: UIColor?, fillColor: UIColor?) {
        self.rect = rect
        self.strokeColor = strokeColor
        self.fillColor = fillColor
    }
}

public struct Rectangle : Shape {
    public let rect : CGRect
    public var strokeColor : UIColor?
    public var fillColor : UIColor?
    public var path : CGPath? {
        return CGPathCreateWithRect(rect, nil)
    }
    public init(rect: CGRect, strokeColor: UIColor?, fillColor: UIColor?) {
        self.rect = rect
        self.strokeColor = strokeColor
        self.fillColor = fillColor
    }
}

public struct RoundedRectangle : Shape {
    public let rect : CGRect
    public var strokeColor : UIColor?
    public var fillColor : UIColor?
    public let cornerRadius : CGFloat
    public var path : CGPath? {
        return CGPathCreateWithRoundedRect(rect, cornerRadius, cornerRadius, nil)
    }
    public init(rect: CGRect, strokeColor: UIColor?, fillColor: UIColor?, cornerRadius: CGFloat = 10) {
        self.rect = rect
        self.strokeColor = strokeColor
        self.fillColor = fillColor
        self.cornerRadius = cornerRadius
    }
}
