//
//  CharactersView.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created for introducing the Flicker family characters
//

import SwiftUI

struct CharactersView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        ZStack {
            // Background
            Image("backgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Title
                    Text(LocalizedText.text(for: "charactersTitle", lang: languageManager.currentLanguage))
                        .font(.custom("Comic Sans MS Bold", size: 48))
                        .bold()
                        .foregroundColor(Color(red: 49/255, green: 94/255, blue: 38/255))
                        .padding(.top, 40)
                    
                    // Flicker Family Section
                    VStack(spacing: 20) {
                        Text(LocalizedText.text(for: "flickerFamilyTitle", lang: languageManager.currentLanguage))
                            .font(.custom("Noteworthy", size: 40))
                            .bold()
                            .foregroundColor(Color(red: 255/255, green: 165/255, blue: 0/255))
                        
                        Text(LocalizedText.text(for: "flickerFamilyDescription", lang: languageManager.currentLanguage))
                            .font(.custom("Noteworthy", size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 20)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(15)
                        
                        // Character Cards
                        VStack(spacing: 30) {
                            CharacterCard(
                                name: LocalizedText.text(for: "flickerMother", lang: languageManager.currentLanguage),
                                description: LocalizedText.text(for: "flickerMotherDesc", lang: languageManager.currentLanguage),
                                color: Color(red: 255/255, green: 220/255, blue: 100/255)
                            )
                            
                            CharacterCard(
                                name: LocalizedText.text(for: "flickerFather", lang: languageManager.currentLanguage),
                                description: LocalizedText.text(for: "flickerFatherDesc", lang: languageManager.currentLanguage),
                                color: Color(red: 255/255, green: 180/255, blue: 50/255)
                            )
                            
                            CharacterCard(
                                name: LocalizedText.text(for: "flickerChildren", lang: languageManager.currentLanguage),
                                description: LocalizedText.text(for: "flickerChildrenDesc", lang: languageManager.currentLanguage),
                                color: Color(red: 255/255, green: 240/255, blue: 150/255)
                            )
                        }
                        .padding(.horizontal, 40)
                    }
                    .padding(.vertical, 20)
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(Color(red: 49/255, green: 94/255, blue: 38/255))
                }
            }
        }
    }
}

// MARK: - Character Card Component
struct CharacterCard: View {
    let name: String
    let description: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "sparkles")
                    .font(.system(size: 30))
                    .foregroundColor(color)
                
                Text(name)
                    .font(.custom("Noteworthy", size: 32))
                    .bold()
                    .foregroundColor(color)
            }
            
            Text(description)
                .font(.custom("Noteworthy", size: 22))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
        }
        .padding(25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.6),
                    Color.black.opacity(0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color.opacity(0.5), lineWidth: 2)
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CharactersView()
            .environmentObject(LanguageManager())
    }
}
