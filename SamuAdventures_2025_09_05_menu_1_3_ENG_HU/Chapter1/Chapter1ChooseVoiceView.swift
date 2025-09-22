//
//  Chapter1ChooseVoiceView.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 18..
//

import SwiftUI
import AVFoundation

struct ReaderVoice: Identifiable {
    let id: String
    let name: String
    let imageName: String
    let introSound: String
    let goodChoiceSound: String
}

let readers: [ReaderVoice] = [
    ReaderVoice(id: "Writer", name: "Writer", imageName: "reader_writer", introSound: "writer_intro_ch1_page0", goodChoiceSound: "Ch1_Page00_Writer_EN"),
    ReaderVoice(id: "Mia", name: "Mia", imageName: "reader_mia", introSound: "mia_intro", goodChoiceSound: "Ch1_Page00_Mia_EN"),
    ReaderVoice(id: "Luca", name: "Luca", imageName: "reader_luca", introSound: "luca_intro", goodChoiceSound: "Ch1_Page00_Luca_EN"),
    ReaderVoice(id: "Manual", name: "I will read myself", imageName: "i will read myself", introSound: "", goodChoiceSound: "")
]

struct Chapter1ChooseVoiceView: View {
    var onConfirm: () -> Void
    @AppStorage("selectedReaderID") var selectedReaderID: String = "Writer"
    @AppStorage("readMode") var readMode: String = "withVoice"
    @State private var bouncingID: String?
    @State private var tappedOnceID: String?
    @State private var didChoose: Bool = false
    @State private var autoPlayTimer: Timer?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlayingIntro: Bool = false
    @State private var isPlayingGoodChoice: Bool = false

    // Volume Control States
    @State private var showVolumeSheet = false
    @State private var backgroundVolume: Double = 1.0
    @State private var narrationVolume: Double = 1.0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("readers_bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // --- Top bar with centered text and green sound button ---
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Who do you want to read this story?")
                            .font(.custom("Noteworthy", size: 57))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .shadow(radius: 4)
                        Spacer()
                        Button(action: {
                            showVolumeSheet.toggle()
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.system(size: 38, weight: .bold))
                                .foregroundColor(.green)
                                .padding(14)
                                .background(Circle().fill(Color.white.opacity(0.85)))
                                .overlay(
                                    Circle()
                                        .stroke(Color.green, lineWidth: 2)
                                )
                        }
                        .padding(.trailing, 38)
                        .padding(.top, 12)
                        .sheet(isPresented: $showVolumeSheet) {
                            VStack(spacing: 30) {
                                Text("Adjust Volumes")
                                    .font(.title2)
                                    .padding(.top)
                                HStack {
                                    Image(systemName: "music.note")
                                    Slider(
                                        value: Binding(
                                            get: { backgroundVolume },
                                            set: { newVal in
                                                backgroundVolume = newVal
                                                AudioManager.shared.setBackgroundVolume(Float(newVal))
                                            }
                                        ),
                                        in: 0...1
                                    )
                                    Text(String(format: "%.0f%%", backgroundVolume * 100))
                                }
                                .padding(.horizontal)
                                HStack {
                                    Image(systemName: "person.wave.2.fill")
                                    Slider(
                                        value: Binding(
                                            get: { narrationVolume },
                                            set: { newVal in
                                                narrationVolume = newVal
                                                audioPlayer?.volume = Float(newVal)
                                            }
                                        ),
                                        in: 0...1
                                    )
                                    Text(String(format: "%.0f%%", narrationVolume * 100))
                                }
                                .padding(.horizontal)
                                Button("Done") {
                                    showVolumeSheet = false
                                }
                                .font(.title3)
                                .padding()
                            }
                            .padding()
                        }
                    }
                    .padding(.top, 30)
                    Spacer()
                    // --- Readers ---
                    ZStack {
                        readerButton(for: readers[0], size: CGSize(width: 540, height: 500))
                            .position(x: geo.size.width * 0.27, y: geo.size.height * 0.33)
                        readerButton(for: readers[1], size: CGSize(width: 340, height: 400))
                            .position(x: geo.size.width * 0.57, y: geo.size.height * 0.18)
                        readerButton(for: readers[2], size: CGSize(width: 340, height: 400))
                            .position(x: geo.size.width * 0.77, y: geo.size.height * 0.18)
                        manualReadButton(for: readers[3], size: CGSize(width: 800, height: 240))
                            .position(x: geo.size.width * 0.72, y: geo.size.height * 0.60)
                    }
                    Spacer()
                }
            }
            .onAppear {
                // Play background music and set volume
                AudioManager.shared.playBackgroundMusic(filename: "chapter 1 intro music")
                AudioManager.shared.setBackgroundVolume(0.3) // ← set to 30%

                autoPlayTimer?.invalidate()
                autoPlayTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    if !didChoose {
                        isPlayingIntro = true
                        startBouncing(id: "Writer")
                        playIntro(for: readers[0])
                    }
                }
            }
            .onDisappear {
                autoPlayTimer?.invalidate()
                stopBouncing()
                stopAudio()
                AudioManager.shared.stopBackground()
            }
        }
    }

    func readerButton(for reader: ReaderVoice, size: CGSize) -> some View {
        let isSelected = selectedReaderID == reader.id && readMode == "withVoice"
        let isBouncing = (bouncingID == reader.id) && (isPlayingIntro || isPlayingGoodChoice)
        return Button(action: {
            stopAudio()
            if tappedOnceID == reader.id {
                didChoose = true
                selectedReaderID = reader.id
                readMode = "withVoice"
                isPlayingGoodChoice = true
                startBouncing(id: reader.id)
                playGoodChoice(for: reader) {
                    // --- VOLUME CHANGES & PAGE SWITCH ---
                    AudioManager.shared.setBackgroundVolume(1.0) // Restore background volume if lowered
                    audioPlayer?.volume = Float(narrationVolume) // Restore narration volume
                    isPlayingGoodChoice = false
                    stopBouncing()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        onConfirm()
                    }
                }
            } else {
                didChoose = true
                tappedOnceID = reader.id
                isPlayingIntro = true
                startBouncing(id: reader.id)
                playIntro(for: reader)
            }
        }) {
            ZStack {
                Image(reader.imageName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(
                        isSelected && tappedOnceID == reader.id ?
                        Circle().stroke(Color.gray.opacity(0.18), lineWidth: 9) : nil
                    )
                VStack {
                    Spacer()
                    Text(reader.id == "Manual" ? "" : reader.name)
                        .font(.custom("Noteworthy", size: 45))
                        .foregroundColor(.primary)
                        .padding(.bottom, 10)
                        .shadow(radius: 2)
                }
            }
            .frame(width: size.width, height: size.height)
            .scaleEffect(isBouncing ? 1.17 : 1.0)
            .animation(isBouncing ? Animation.easeInOut(duration: 0.35).repeatForever(autoreverses: true) : .default, value: isBouncing)
        }
        .buttonStyle(PlainButtonStyle())
        .shadow(radius: 8)
    }

    // Only show the image for Manual (no overlay text)
    func manualReadButton(for reader: ReaderVoice, size: CGSize) -> some View {
        let isBouncing = bouncingID == reader.id && (isPlayingIntro || isPlayingGoodChoice)
        return Button(action: {
            stopAudio()
            if tappedOnceID == reader.id {
                didChoose = true
                readMode = "alone"
                selectedReaderID = reader.id
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    onConfirm()
                }
            } else {
                didChoose = true
                tappedOnceID = reader.id
                startBouncing(id: reader.id)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    stopBouncing()
                }
            }
        }) {
            Image(reader.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: size.width, height: size.height)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .scaleEffect(isBouncing ? 1.08 : 1.0)
                .animation(isBouncing ? Animation.easeInOut(duration: 0.35).repeatForever(autoreverses: true) : .default, value: isBouncing)
        }
        .buttonStyle(PlainButtonStyle())
        .shadow(radius: 8)
    }

    // --- Bouncing Logic ---
    func startBouncing(id: String) { bouncingID = id }
    func stopBouncing() {
        bouncingID = nil
        isPlayingIntro = false
        isPlayingGoodChoice = false
    }

    // --- Sound Logic ---
    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlayingIntro = false
        isPlayingGoodChoice = false
    }

    func playIntro(for reader: ReaderVoice) {
        guard !reader.introSound.isEmpty else { stopBouncing(); return }
        isPlayingIntro = true // Explicitly set for safety
        AudioManager.shared.setBackgroundVolume(0.2) // Lower background during narration
        if let url = Bundle.main.url(forResource: reader.introSound, withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.volume = Float(narrationVolume)
                audioPlayer = player
                player.delegate = AVAudioPlayerDelegateWrapper(onFinish: {
                    AudioManager.shared.setBackgroundVolume(1.0) // Restore after narration
                    isPlayingIntro = false
                    stopBouncing()
                })
                player.play()
            } catch {
                AudioManager.shared.setBackgroundVolume(1.0)
                stopBouncing()
            }
        } else {
            AudioManager.shared.setBackgroundVolume(1.0)
            stopBouncing()
        }
    }

    func playGoodChoice(for reader: ReaderVoice, completion: @escaping () -> Void) {
        guard !reader.goodChoiceSound.isEmpty else {
            completion()
            return
        }
        AudioManager.shared.setBackgroundVolume(0.2) // Lower background during good choice narration
        if let url = Bundle.main.url(forResource: reader.goodChoiceSound, withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.volume = Float(narrationVolume)
                audioPlayer = player
                player.delegate = AVAudioPlayerDelegateWrapper(onFinish: {
                    AudioManager.shared.setBackgroundVolume(0.6) // Restore background volume
                    completion()
                })
                player.play()
            } catch {
                AudioManager.shared.setBackgroundVolume(1.0)
                completion()
            }
        } else {
            AudioManager.shared.setBackgroundVolume(1.0)
            completion()
        }
    }
}

class AVAudioPlayerDelegateWrapper: NSObject, AVAudioPlayerDelegate {
    var onFinish: () -> Void
    init(onFinish: @escaping () -> Void) { self.onFinish = onFinish }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onFinish()
    }
}
