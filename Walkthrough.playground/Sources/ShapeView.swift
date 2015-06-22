import UIKit

public class ShapeView : UIView {

    var shape : Shape? {
        didSet {
            self.reloadData()
        }
    }

    public convenience init(shape: Shape) {
        self.init(frame: shape.rect)
        self.shape = shape
        self.backgroundColor = UIColor.clearColor()
        self.reloadData()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private var shapeLayer : CAShapeLayer {
        return self.layer as! CAShapeLayer
    }

    public override static func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }

    func reloadData() {
        if let shape = shape {
            self.frame = shape.rect
            self.shapeLayer.strokeColor = shape.strokeColor?.CGColor
            self.shapeLayer.fillColor = shape.fillColor?.CGColor
            self.shapeLayer.path = shape.path
        }
    }
}