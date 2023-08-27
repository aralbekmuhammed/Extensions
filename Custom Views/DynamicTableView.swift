import UIKit

class DynamicHeightTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        snp.makeConstraints { make in
            make.height.equalTo(0).priority(.high)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
        snp.updateConstraints { make in
            make.height.equalTo(intrinsicContentSize.height).priority(.high)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    override func reloadData() {
        super.reloadData()
        self.layoutIfNeeded()
    }
}
