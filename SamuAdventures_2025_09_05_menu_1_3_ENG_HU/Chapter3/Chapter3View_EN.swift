//
//  Chapter3View.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 06..
//

import SwiftUI
import AVFoundation

struct Chapter3View_EN: View {
    @Environment(\.dismiss) var dismiss  // allows going back

    // --- Add this ---
    @StateObject var audioManager = AudioManager()
    // ------------------

    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Page TabView
            TabView {
                Image("Ch3_Page01_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()

                Image("Ch3_Page02_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()

                Image("Ch3_Page03_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page04_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page05_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page06_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page07_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page08_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page09_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page010_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page011_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                MathDragGameView()
                
                Image("Ch3_Page013_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page014_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page015_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page016_EN")
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
