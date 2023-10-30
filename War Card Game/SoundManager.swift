import AVFoundation
import AVKit

class SoundManager: ObservableObject {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    enum soundOption: String {
        case cardflip = "CardFlip"
        case lose = "Lose"
        case theme = "Theme"
        case win = "Win"
    }

    func playSound(sound: soundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: [.duckOthers, .mixWithOthers])
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
}
