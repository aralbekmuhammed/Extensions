import UIKit
import Photos
import Combine

class AssetCell: UICollectionViewCell {
    
    @Published var item: PHAsset?
    
    private var requestID: PHImageRequestID?
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var thumbnailImage: UIImageView = {
        UIImageView().then {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupCombine()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let requestID {
            PHImageManager.default().cancelImageRequest(requestID)
        }
        thumbnailImage.image = nil
    }
    
    private func setupCombine(){
        $item
            .receive(on: DispatchQueue.global(qos: .userInteractive))
            .sink { [weak self] asset in
                if let requestID = self?.requestID{
                    PHImageManager.default().cancelImageRequest(requestID)
                }
                
                guard let self, let asset else {
                    DispatchQueue.main.async { [weak self] in
                        self?.thumbnailImage.image = nil
                    }
                    return
                }
                
                self.requestID = PHImageManager.default().requestImage(for: asset,
                                                                       targetSize: .init(width: 720, height: 720),
                                                                       contentMode: .aspectFill,
                                                                       options: nil) { image, _ in
                    DispatchQueue.main.async { [weak self] in
                        self?.thumbnailImage.image = image
                    }
                }
            }.store(in: &subscriptions)
    }
    
    private func setupViews(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(thumbnailImage)
        contentView.clipsToBounds = true
    }
    
    private func setupConstraints(){
        thumbnailImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
