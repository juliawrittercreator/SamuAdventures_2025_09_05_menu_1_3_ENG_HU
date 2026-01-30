//
//  Main_Menu.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 05..
//

//
//  Main_Menu.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 05..
//

import SwiftUI

// ---------- Main view ----------
struct Main_Menu: View {
    // 3 flexible columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // State to toggle dropdown
    @State private var showMenu = false
    @State private var showLanguageMenu = false
    @State private var showChooseReader = false
    @State private var showDrawing = false
    
    // Language manager
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                // --- Background ---
                Image("backgroundImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // --- Main content (top bar + grid) ---
                VStack(spacing: 0) {
                    // MARK: - Top Menu Bar
                    HStack {
                        Button(action: { withAnimation { showMenu.toggle() } }) {
                            Image(systemName: "line.horizontal.3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 30)
                                .padding(.leading, 50)
                                .padding(.top, 40)
                                .padding(.trailing, 16)
                        }
                        
                        Text(LocalizedText.text(for: "title", lang: languageManager.currentLanguage))
                            .font(.custom("Comic Sans MS Bold", size: 40))
                            .bold()
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .padding(.top, 40)
                            .padding(.trailing, 16)
                        
                        Button(action: { print("Profile tapped") }) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.trailing, 70)
                        }
                        .padding(.top, 40)
                        .padding(.trailing, 16)
                    }
                    .frame(height: 120)
                    .background(.ultraThinMaterial)
                    .shadow(radius: 4)
                    
                    // MARK: - Scrollable Grid of Chapters
                    ScrollView(.vertical, showsIndicators: true) {
                        LazyVGrid(columns: columns, spacing: 24) {
                            
                            // Chapter 1 (language-dependent)
                            NavigationLink(destination:
                                languageManager.currentLanguage == .english
                                    ? AnyView(Chapter1View())
                                    : AnyView(Chapter1ViewHUN())
                            ) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch1",
                                                  chapterKey: "chapter1",
                                                  color: Color(red: 49/255, green: 94/255, blue: 38/255))
                            }
                            
                            // Chapter 2
                            NavigationLink(destination: Chapter2View()) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch2",
                                                  chapterKey: "chapter2",
                                                  color: Color(red: 49/255, green: 94/255, blue: 80/122))
                            }
                            
                            // Chapter 3 (language-dependent)
                            NavigationLink(destination: languageManager.currentLanguage == .english
                                           ? AnyView(Chapter3View_EN())
                                           : AnyView(Chapter3View_HUN())) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch3",
                                                  chapterKey: "chapter3",
                                                  color: Color(red: 200/255, green: 94/255, blue: 80/122))
                            }
                            
                            // Chapter 4
                            NavigationLink(destination: languageManager.currentLanguage == .english
                                           ? AnyView(Chapter4View_EN())
                                           : AnyView(Chapter3View_HUN())) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch4",
                                                  chapterKey: "chapter4",
                                                  color: Color(red: 255/255, green: 165/255, blue: 0/255))
                            }
                            
                            // Chapter 5
                            NavigationLink(destination: Chapter2View()) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch5",
                                                  chapterKey: "chapter5",
                                                  color: Color(red: 34/255, green: 139/255, blue: 34/255))
                            }
                            
                            // Chapter 6
                            NavigationLink(destination: Chapter2View()) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch6",
                                                  chapterKey: "chapter6",
                                                  color: Color(red: 255/255, green: 130/255, blue: 193/255))
                            }
                            
                            // Chapter 7
                            NavigationLink(destination: Chapter2View()) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch7",
                                                  chapterKey: "chapter7",
                                                  color: Color(red: 20/255, green: 130/255, blue: 193/255))
                            }
                            
                            // Chapter 8
                            NavigationLink(destination: Chapter2View()) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch8",
                                                  chapterKey: "chapter8",
                                                  color: Color(red: 160/255, green: 130/255, blue: 100/255))
                            }
                            
                            // Chapter 9
                            NavigationLink(destination: Chapter2View()) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch9",
                                                  chapterKey: "chapter9",
                                                  color: Color(red: 255/255, green: 100/255, blue: 20/255))
                            }
                            
                            // Chapter 10
                            NavigationLink(destination: Chapter2View()) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch10",
                                                  chapterKey: "chapter10",
                                                  color: Color(red: 100/255, green: 170/255, blue: 250/255))
                            }
                            
                            // Chapter 11
                            NavigationLink(destination: Chapter2View()) {
                                ChapterButtonView(languageManager: languageManager,
                                                  chapterImage: "btn_ch11",
                                                  chapterKey: "chapter11",
                                                  color: Color(red: 255/255, green: 130/255, blue: 140/255))
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
                
                // MARK: - Tap catcher & Dropdown Overlay
                if showMenu {
                    Color.black.opacity(0.001)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showMenu = false
                                showLanguageMenu = false
                            }
                        }
                        .zIndex(5)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Button(LocalizedText.text(for: "characters", lang: languageManager.currentLanguage)) {
                            print("Characters tapped")
                            withAnimation { showMenu = false }
                        }
                        .costummenuItemStyle()
                        
                        Button(LocalizedText.text(for: "drawing", lang: languageManager.currentLanguage)) {
                            withAnimation { showMenu = false }
                            showDrawing = true
                        }
                        .costummenuItemStyle()
                        
                        Button(LocalizedText.text(for: "Readers", lang: languageManager.currentLanguage)) {
                            withAnimation { showMenu = false }
                            showChooseReader = true
                        }
                        .costummenuItemStyle()
                        
                        Button(LocalizedText.text(for: "map", lang: languageManager.currentLanguage)) {
                            print("Map tapped")
                            withAnimation { showMenu = false }
                        }
                        .costummenuItemStyle()
                        
                        Button(LocalizedText.text(for: "language", lang: languageManager.currentLanguage)) {
                            withAnimation { showLanguageMenu.toggle() }
                        }
                        .costummenuItemStyle()
                        
                        if showLanguageMenu {
                            VStack(alignment: .leading, spacing: 6) {
                                Button("English") {
                                    languageManager.currentLanguage = .english
                                    withAnimation { showMenu = false; showLanguageMenu = false }
                                }
                                .costummenuItemStyle()
                                
                                Button("Magyar") {
                                    languageManager.currentLanguage = .hungarian
                                    withAnimation { showMenu = false; showLanguageMenu = false }
                                }
                                .costummenuItemStyle()
                            }
                            .padding(.leading, 6)
                        }
                        
                        Button(LocalizedText.text(for: "creator", lang: languageManager.currentLanguage)) {
                            print("Creator tapped")
                            withAnimation { showMenu = false }
                        }
                        .costummenuItemStyle()
                        
                        Button(LocalizedText.text(for: "payment", lang: languageManager.currentLanguage)) {
                            print("Payment tapped")
                            withAnimation { showMenu = false }
                        }
                        .costummenuItemStyle()
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .frame(maxWidth: 250, alignment: .leading)
                    .offset(x: 24, y: 120)
                    .zIndex(10)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .navigationBarHidden(true)
            // ✅ New navigation destination
            .navigationDestination(isPresented: $showChooseReader) {
                ChooseReaderView()
            }
            .navigationDestination(isPresented: $showDrawing) {
                DrawingCanvasView()
            }
        }
    }
}

// MARK: - Chapter Button Reusable View
struct ChapterButtonView: View {
    @ObservedObject var languageManager: LanguageManager
    var chapterImage: String
    var chapterKey: String
    var color: Color

    var body: some View {
        VStack(spacing: 1) {
            Image(chapterImage)
                .resizable()
                .scaledToFill()
                .frame(width: 340, height: 340)
                .clipped()
                .cornerRadius(12)

            Text(LocalizedText.text(for: chapterKey, lang: languageManager.currentLanguage))
                .font(.custom("Noteworthy", size: 43))
                .lineLimit(1)
                .bold()
                .minimumScaleFactor(0.5)
                .foregroundColor(color)
        }
    }
}

// MARK: - Custom menu button style
extension Button {
    func costummenuItemStyle() -> some View {
        self
            .font(.custom("Noteworthy", size: 24))
            .bold()
            .foregroundColor(Color(red: 49/255, green: 94/255, blue: 38/255))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.white.opacity(0.1))
            .cornerRadius(8)
    }
}

// MARK: - Preview
#Preview {
    Main_Menu()
        .environmentObject(LanguageManager())
        .previewDevice("iPad Pro (11-inch)")
}
