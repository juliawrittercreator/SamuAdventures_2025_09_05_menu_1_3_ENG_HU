//
//  narrationMap.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 20..
//

import SwiftUI
import AVFoundation

struct narrationMap: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var audioManager = AudioManager()
    @State private var bounce = false
    @State private var selectedTab = 0   // Track the current tab

    @AppStorage("selectedReaderID") var selectedReaderID: String = "Writer"

    // MARK: - Narration Map
    // [pageTag: [readerID: narration file name]]
    let narrationMap: [Int: [String: String]] = [
        1: [ // Page 1
            "Writer": "Ch1_Page01_Writer_EN",
            "Mia":    "Ch1_Page01_Mia_EN",
            "Luca":   "Ch1_Page01_Luca_EN"
        ],
        2: [ // Page 2
            "Writer": "Ch1_Page02_narration_Writer",
            "Mia":    "Ch1_Page02_narration_Mia",
            "Luca":   "Ch1_Page02_narration_Luca"
        ],
        // Add more pages and readers as needed
        5: [ // Page 5 example
            "Writer": "Ch1_Page05_Writer_EN",
            "Mia":    "Ch1_Page05_Mia_EN",
            "Luca":   "Ch1_Page05_Luca_EN"
        ]
        // etc.
    ]

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                // ... your page views, unchanged ...
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onChange(of: selectedTab) { newTab in
                SoundPlayer.stop()
                playNarration(for: newTab)
            }
        }
        .onAppear {
            audioManager.playBackgroundMusic(filename: "chapter1_intro_music")
            playNarration(for: selectedTab)
        }
        .onDisappear {
            audioManager.stopBackground()
            SoundPlayer.stop()
        }
    }

    // MARK: - Play Narration
    func playNarration(for tab: Int) {
        guard let readerDict = narrationMap[tab],
              let fileName = readerDict[selectedReaderID], !fileName.isEmpty else {
            return
        }
        SoundPlayer.playSound(named: fileName)
    }
}
