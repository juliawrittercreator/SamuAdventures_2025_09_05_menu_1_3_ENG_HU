//
//  error.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 06..
//


import SwiftUI
import AVFoundation

struct error: View {
    @Environment(\.dismiss) var dismiss  // allows going back

    // --- Add this ---
    @StateObject var audioManager = AudioManager()
    // ------------------

    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Page TabView
            TabView {
                Image("Ch1_Page01_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()

                // Page 2: Scratch-off hedgehog
                    ScratchHedgehogView()

                Image("Ch1_Page03_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page04_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page05_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page06_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page07_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page08_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page09_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page010_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page011_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch1_Page012_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        // --- Add this block ---
        .onAppear {
            audioManager.playBackgroundMusic(filename: "chapter1_intro_music") // put your mp3 in assets
        }
        .onDisappear {
            audioManager.stopBackground()
        }
        // ----------------------
    }
}


