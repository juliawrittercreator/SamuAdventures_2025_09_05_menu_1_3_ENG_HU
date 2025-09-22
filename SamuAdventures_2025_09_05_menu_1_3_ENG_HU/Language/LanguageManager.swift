//
//  LanguageManager.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 06..
//

// LanguageManager.swift
import SwiftUI

enum AppLanguage: String {
    case english = "en"
    case hungarian = "hu"
}

final class LanguageManager: ObservableObject {
    @Published var currentLanguage: AppLanguage = .english
}
