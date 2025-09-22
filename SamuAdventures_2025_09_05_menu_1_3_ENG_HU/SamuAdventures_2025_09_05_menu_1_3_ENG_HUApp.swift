//
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HUApp.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 05..
//

import SwiftUI

enum ReadMode {
    case withVoice
    case alone
}

class AppSettings: ObservableObject {
    static let shared = AppSettings()
    
    @Published var readMode: ReadMode = .withVoice
    @Published var selectedReaderId: String? = "Writer"   // Default to Writer, can be "Mia", "Luca", etc.
}

@main
struct SamuAdventures_2025_09_05_menu_1_3_ENG_HUApp: App {
    @StateObject private var appSettings = AppSettings.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Main_Menu()
            }
            .environmentObject(appSettings) // Make AppSettings available everywhere
        }
    }
}
