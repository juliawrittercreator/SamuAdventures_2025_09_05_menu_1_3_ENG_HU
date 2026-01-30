//
//  LocalizedText.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 06..
//

// LocalizedText.swift
import Foundation

struct LocalizedText {
    static let content: [AppLanguage: [String: String]] = [
        .english: [
            "title": "Samu's Adventures",
            "characters": "Characters",
            "map": "Map",
            "language": "Language",
            "creator": "Creator",
            "payment": "Payment",
            "chapter1": "Samu and the Eagle",
            "chapter2": "My Friend, The Wind",
            "chapter3": "A Colorful Day",
            "chapter4": "Hearing the Birds",
            "chapter5": "Planting Trees",
            "chapter6": "The Mix-up",
            "chapter7": "The Moonshoe",
            "chapter8": "The Dancing Flame",
            "chapter9": "The Sound Catcher",
            "chapter10": "The River Disappeared",
            "chapter11": "Birthday Waffles",
            "drawing": "Drawing",
            "back": "Back",
            "clear": "Clear",
            "line_width": "Brush Size:",
            "Readers": "Readers"
        ],
        .hungarian: [
            "title": "Samu kalandjai",
            "characters": "Szereplők",
            "map": "Térkép",
            "language": "Nyelv",
            "creator": "Készítő",
            "payment": "Fizetés",
            "chapter1": "Samu és a sas",
            "chapter2": "A barátom, a szél",
            "chapter3": "Egy színes nap",
            "chapter4": "Madarak hallgatása",
            "chapter5": "Fák ültetése",
            "chapter6": "A keveredés",
            "chapter7": "Holdcipő",
            "chapter8": "A táncoló láng",
            "chapter9": "A hangfogó",
            "chapter10": "Eltűnt a folyó",
            "chapter11": "Születésnapi gofri",
            "drawing": "Rajzolás",
            "back": "Vissza",
            "clear": "Törlés",
            "line_width": "Ecset méret:",
            "Readers": "Felolvasók"
        ]
    ]
    
    static func text(for key: String, lang: AppLanguage) -> String {
        content[lang]?[key] ?? key
    }
}
