//
//  AudioManager.swift
//  1
//
//  Created by Eva Julia Boros on 2025. 08. 30..
//


import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    static let shared = AudioManager()

    var backgroundPlayer: AVAudioPlayer?

    func playBackgroundMusic(filename: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set AVAudioSession: \(error)")
        }

        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("Background music file not found: \(filename).mp3")
            return
        }
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1  // loop indefinitely
            backgroundPlayer?.volume = 0.1         // Set volume to 10%
            backgroundPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }

    func setBackgroundVolume(_ volume: Float) {
        backgroundPlayer?.volume = volume
    }

    func stopBackground() { backgroundPlayer?.stop() }
}
