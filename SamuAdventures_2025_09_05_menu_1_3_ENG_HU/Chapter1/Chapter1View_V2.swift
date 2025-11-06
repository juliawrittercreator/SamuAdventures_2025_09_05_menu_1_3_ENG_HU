//
// Chapter1View_V2.swift
// UX Design Test Version
//
//  Created for UX testing on 2025. 11. 06..
//

import SwiftUI
import AVFoundation

struct Chapter1View_V2: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var audioManager = AudioManager()
    @State private var bounce = false
    @State private var selectedTab = 0
    @State private var showPageIndicator = true

    @AppStorage("selectedReaderID") var selectedReaderID: String = "Writer"
    @AppStorage("readMode") var readMode: String = "withVoice"

    private let totalPages = 13
    
    var body: some View {
        ZStack {
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
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: selectedTab) { newTab in
                    handleNarration(for: newTab)
                }
            }
            
            // UX Enhancement: Custom page indicator with progress bar
            VStack {
                HStack {
                    Spacer()
                    
                    VStack(spacing: 8) {
                        // Progress text
                        Text("Page \(selectedTab + 1) of \(totalPages)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color.black.opacity(0.6))
                            )
                        
                        // Progress bar
                        HStack(spacing: 4) {
                            ForEach(0..<totalPages, id: \.self) { index in
                                Capsule()
                                    .fill(index <= selectedTab ? Color.green : Color.white.opacity(0.3))
                                    .frame(width: 8, height: 8)
                                    .animation(.spring(), value: selectedTab)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.6))
                        )
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                    .opacity(showPageIndicator && selectedTab > 0 ? 1 : 0)
                    .animation(.easeInOut, value: showPageIndicator)
                }
                
                Spacer()
                
                // UX Enhancement: Navigation buttons
                if selectedTab > 0 && selectedTab < 12 {
                    HStack {
                        // Previous button
                        if selectedTab > 1 {
                            Button(action: {
                                withAnimation {
                                    selectedTab -= 1
                                }
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "chevron.left")
                                    Text("Previous")
                                }
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(
                                    Capsule()
                                        .fill(Color.blue.opacity(0.8))
                                )
                                .shadow(radius: 4)
                            }
                            .padding(.leading, 20)
                        }
                        
                        Spacer()
                        
                        // Next button
                        if selectedTab < 11 {
                            Button(action: {
                                withAnimation {
                                    selectedTab += 1
                                }
                            }) {
                                HStack(spacing: 8) {
                                    Text("Next")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(
                                    Capsule()
                                        .fill(Color.blue.opacity(0.8))
                                )
                                .shadow(radius: 4)
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    .padding(.bottom, 30)
                }
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
        .gesture(
            DragGesture()
                .onChanged { _ in
                    // Hide indicators while swiping
                    showPageIndicator = false
                }
                .onEnded { _ in
                    // Show indicators after swipe
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showPageIndicator = true
                    }
                }
        )
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
        default:
            break
        }
    }
}
