//
//  Chapter3View_HUN.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 06..
//

import SwiftUI
import AVFoundation

struct Chapter3View_HUN: View {
    @Environment(\.dismiss) var dismiss  // allows going back

    @StateObject var audioManager = AudioManager()

    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Page TabView
            TabView {
                Image("Ch3_Page01_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()

                Image("Ch3_Page02_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()

                Image("Ch3_Page03_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page04_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page05_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page06_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page07_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page08_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page09_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page010_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page011_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page012_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page013_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page014_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page015_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch3_Page016_Hun")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .onAppear {
            audioManager.playBackgroundMusic(filename: "chapter1_intro_music") // update if you have chapter3 music
        }
        .onDisappear {
            audioManager.stopBackground()
        }
    }
}
