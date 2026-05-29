import Foundation
import AVFoundation



class NotificationSoundManager {
    static let shared = NotificationSoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playAlarmSound() {
        guard let url = Bundle.main.url(forResource: "freesound_community-alarmclock-bell-ringing-clear-windingdown-000212_0029s3_d-095-099-031-042-35592", withExtension: "mp3") else {
            print("Sounddatei nicht gefunden.")
            return
        }
        
        do {
            
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
            print("Wecksound wird abgespielt")
        } catch {
            print("Fehler beim Abspielen des Sounds: \(error.localizedDescription)")
        }
    }
    
    func stopAlarmSound() {
        audioPlayer?.stop()
        print("Wecksound gestoppt.")
    }
}
