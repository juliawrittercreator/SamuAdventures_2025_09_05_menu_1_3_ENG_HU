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
            "charactersTitle": "Meet the Characters",
            "back": "Back",
            "flickerFamilyTitle": "The Flicker Family",
            "flickerFamilyDescription": "The Flicker family are magical fireflies who live near the Dancing Flame. They light up the forest with their warm, gentle glow and help Samu find his way through the darkest nights.",
            "flickerMother": "Mother Flicker",
            "flickerMotherDesc": "The wise and caring mother who teaches the young fireflies how to shine their brightest.",
            "flickerFather": "Father Flicker",
            "flickerFatherDesc": "The protective father who guards the flame and keeps it dancing with joy.",
            "flickerChildren": "The Flicker Children",
            "flickerChildrenDesc": "Playful young fireflies who love to play hide-and-seek in the twilight."
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
            "charactersTitle": "Ismerje meg a szereplőket",
            "back": "Vissza",
            "flickerFamilyTitle": "A Villogó család",
            "flickerFamilyDescription": "A Villogó család varázslatos szentjánosbogarak, akik a Táncoló láng közelében élnek. Meleg, gyengéd fényükkel világítják be az erdőt, és segítenek Samunak megtalálni az utat a legsötétebb éjszakákon.",
            "flickerMother": "Villogó anya",
            "flickerMotherDesc": "A bölcs és gondoskodó anya, aki megtanítja a fiatal szentjánosbogárokat, hogyan ragyogjanak a legfényesebben.",
            "flickerFather": "Villogó apa",
            "flickerFatherDesc": "A védelmező apa, aki őrzi a lángot és örömmel táncoltatja azt.",
            "flickerChildren": "A Villogó gyerekek",
            "flickerChildrenDesc": "Játékos fiatal szentjánosbogarak, akik szeretnek bújócskázni az alkonyatban."
        ]
    ]
    
    static func text(for key: String, lang: AppLanguage) -> String {
        content[lang]?[key] ?? key
    }
}
