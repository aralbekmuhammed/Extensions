import UIKit

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
        @unknown default: self = .up
        }
    }
}

extension CGSize{
    
    var center: CGPoint {
        .init(x: width / 2, y: height / 2)
    }

    init(square: CGFloat){
        self.init(width: square, height: square)
    }
    
}

extension CGPoint{
    func cartesian(in extent: CGSize) -> CGPoint{
        CGPoint(x: x, y: extent.height - y)
    }
}

extension CGRect {
    var center: CGPoint {
        .init(x: origin.x + width / 2, y: origin.y + height / 2)
    }
}

extension Array where Element == CGPoint {
    var bezierPath: UIBezierPath{
        let path = UIBezierPath()
        if count > 1 {
            path.move(to: first!)
            
            for i in 1..<count {
                let point = self[i]
                path.addLine(to: point)
            }
            
            path.close()
        }
        return path        
    }
}

