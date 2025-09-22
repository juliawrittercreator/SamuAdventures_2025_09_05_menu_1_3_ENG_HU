//
//  Chapter1ViewHUN.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 17..
//

import SwiftUI
import AVFoundation

struct Chapter1ViewHUN: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var audioManager = AudioManager()
    @State private var bounce = false
    @State private var selectedTab = 0   // <--- Track the current tab

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                Image("Ch1_Page01_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(0)

                ScratchHedgehogViewHUN()
                    .tag(1)

                Image("Ch1_Page03_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(2)

                PuzzleLakeView()
                    .tag(3)

                Image("Ch1_Page05_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(4)

                Image("Ch1_Page06_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(5)

                Image("Ch1_Page07_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(6)

                Image("Ch1_Page08_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(7)

                Image("Ch1_Page09_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(8)

                Image("Ch1_Page010_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(9)

                Image("Ch1_Page011_HU")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(10)

                // Last page with bouncing button
                ZStack {
                    Image("Ch1_Page012_HU")
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
                .tag(11)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onChange(of: selectedTab) { newTab in
                SoundPlayer.stop()
                switch newTab {
                case 0:
                    SoundPlayer.playSound(named: "Ch1_Page01_Rachelle")
                case 1:
                    SoundPlayer.playSound(named: "Ch1_Page02_narration_Rachelle")
                // Add more cases for more pages if needed
                default:
                    break
                }
            }
        }
        .onAppear {
            audioManager.playBackgroundMusic(filename: "chapter1_intro_music")
            // Optionally start narration for page 0 on startup
            SoundPlayer.playSound(named: "Ch1_Page01_Rachelle")
        }
        .onDisappear {
            audioManager.stopBackground()
            SoundPlayer.stop()
        }
    }
}
