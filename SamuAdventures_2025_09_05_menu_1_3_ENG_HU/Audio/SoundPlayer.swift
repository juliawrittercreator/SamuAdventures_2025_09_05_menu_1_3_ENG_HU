//
//  SoundPlayer.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 17..
//

import AVFoundation

class SoundPlayer {
    static var audioPlayer: AVAudioPlayer?

    static func playSound(named name: String) {
        // Set up the audio session for playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set AVAudioSession: \(error)")
        }
        
        // Try supported extensions in order
        let extensions = ["mp3", "mp4"]
        
        for ext in extensions {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.prepareToPlay()
                    audioPlayer?.play()
                    return  // success → stop checking
                } catch {
                    print("Error playing sound \(name).\(ext): \(error.localizedDescription)")
                    return
                }
            }
        }
        
        print("❌ Sound file not found: \(name).mp3 or \(name).mp4")
    }

    static func stop() {
        audioPlayer?.stop()
    }
}
