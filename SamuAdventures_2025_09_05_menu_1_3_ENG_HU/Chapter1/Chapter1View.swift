//
// Chapter1View.swift
//
//
//  Created by Eva Julia Boros on 2025. 08. 30..
//
//
// Chapter1View.swift
//
//  Created by Eva Julia Boros on 2025. 08. 30..
//

import SwiftUI
import AVFoundation

struct Chapter1View: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var audioManager = AudioManager()
    @State private var bounce = false
    @State private var selectedTab = 0   // Track the current tab

    @AppStorage("selectedReaderID") var selectedReaderID: String = "Writer"
    @AppStorage("readMode") var readMode: String = "withVoice"

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                // PAGE 0: Voice selection page
                Chapter1ChooseVoiceView(onConfirm: {
                    selectedTab = 1
                })
                .tag(0)

                // PAGE 1: Story page 1
                Image("Ch1_Page01_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(1)

                ScratchHedgehogView()
                    .tag(2)

                Image("Ch1_Page03_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(3)

                PuzzleLakeView()
                    .tag(4)

                Image("Ch1_Page05_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(5)

                Image("Ch1_Page06_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(6)

                Image("Ch1_Page07_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(7)

                Image("Ch1_Page08_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(8)

                Image("Ch1_Page09_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(9)

                Image("Ch1_Page010_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(10)

                Image("Ch1_Page011_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(11)

                // Last page with bouncing button
                ZStack {
                    Image("Ch1_Page012_EN")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .opacity(0.9)

                    VStack {
                        Spacer()
                        NavigationLink(destination: Chapter2View()) {
                            Image("1_next_chapter_button")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 840, height: 530)
                                .shadow(radius: 8)
                                .scaleEffect(bounce ? 1.07 : 1.0)
                                .offset(y: bounce ? -16 : 0)
                                .animation(
                                    Animation.easeInOut(duration: 0.75).repeatForever(autoreverses: true),
                                    value: bounce
                                )
                                .position(x: 850, y: 500)
                        }
                        .padding(.bottom, 48)
                    }
                }
                .onAppear {
                    bounce = true
                }
                .tag(12)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onChange(of: selectedTab) { newTab in
                handleNarration(for: newTab)
            }
        }
        .onAppear {
            audioManager.playBackgroundMusic(filename: "chapter1_intro_music")
            if selectedTab == 1 {
                handleNarration(for: 1)
            }
        }
        .onDisappear {
            audioManager.stopBackground()
            SoundPlayer.stop()
        }
    }

    /// Play the appropriate narration for a given page, respecting `readMode` and `selectedReaderID`
    private func handleNarration(for page: Int) {
        SoundPlayer.stop()
        guard readMode == "withVoice" else { return }
        let reader = selectedReaderID

        switch page {
        case 1:
            SoundPlayer.playSound(named: "Ch1_Page01_\(reader)")
        case 2:
            SoundPlayer.playSound(named: "Ch1_Page02_narration_\(reader)")
        case 3:
            SoundPlayer.playSound(named: "Ch1_Page03_narration_\(reader)")
        case 4:
            SoundPlayer.playSound(named: "Ch1_Page04_narration_\(reader)")
        case 5:
            SoundPlayer.playSound(named: "Ch1_Page05_narration_\(reader)")
        case 6:
            SoundPlayer.playSound(named: "Ch1_Page06_narration_\(reader)")
        case 7:
            SoundPlayer.playSound(named: "Ch1_Page07_narration_\(reader)")
        case 8:
            SoundPlayer.playSound(named: "Ch1_Page08_narration_\(reader)")
        case 9:
            SoundPlayer.playSound(named: "Ch1_Page09_narration_\(reader)")
        case 10:
            SoundPlayer.playSound(named: "Ch1_Page010_narration_\(reader)")
        case 11:
            SoundPlayer.playSound(named: "Ch1_Page011_narration_\(reader)")
        case 12:
            SoundPlayer.playSound(named: "Ch1_Page012_narration_\(reader)")
        // If you have more pages with audio, add their cases here.
        default:
            break
        }
    }
}
