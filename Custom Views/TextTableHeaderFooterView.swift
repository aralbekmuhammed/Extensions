import UIKit

class TextTableHeaderFooterView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        .init()
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
