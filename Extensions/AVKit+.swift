import Foundation
import AVKit

extension AVPlayer {
    
    var itemDuration: TimeInterval? {
        guard let duration = currentItem?.duration else { return nil }
        
        return TimeInterval(CMTimeGetSeconds(duration))
    }
    
    func seek(to progress: Float){
        guard let item = currentItem else { return }
        
        let currentTime = CMTimeMultiplyByFloat64(item.duration, multiplier: Float64(progress))
        seek(to: currentTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    func seek(_ seconds: Double){
        let currentTime = currentTime()
        let time = CMTimeMakeWithSeconds(currentTime.seconds + seconds, preferredTimescale: 1000);
        seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
}
