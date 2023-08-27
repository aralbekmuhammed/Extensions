import UIKit
import CoreMedia
import AVKit

extension URL {
    
    static var privacyPolicy: URL { .init(string: "https://www.google.com")! }
    
    static var termsOfUse: URL { .init(string: "https://www.google.com")! }
    
    static var support: URL { .init(string: "https://www.google.com")! }
    
    static var applicationLink: URL { .init(string: "https://apps.apple.com/us/app/apple-music/id1108187390")! }
    
    static var appReviewLink: URL { .init(string: "https://apps.apple.com/app/id1108187390?action=write-review")! }
    
    func getFrameOfVideo() -> CGSize? {
        guard let track = AVURLAsset(url: self).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }

    func getThumbnail(at time: TimeInterval = .zero,
                      completion: @escaping ClosureItem<UIImage?>) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: self)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumbnailTime = CMTime(seconds: time, preferredTimescale: 1000)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}
