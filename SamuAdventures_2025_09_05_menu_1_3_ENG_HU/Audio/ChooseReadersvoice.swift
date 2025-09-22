//
//  ChooseReadersvoice.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 18..
//

import SwiftUI
import AVFoundation

struct Readers: Identifiable {
    let id: String
    let name: String
    let imageName: String
    let introSound: String // mp3 filename
    let borderColor: Color
}

let readersEnglish: [Readers] = [
    Readers(id: "Writer", name: "Writer", imageName: "reader_writer", introSound: "writer_intro", borderColor: .clear),
    Readers(id: "Mia", name: "Mia", imageName: "reader_mia", introSound: "mia_intro", borderColor: .clear ),
    Readers(id: "Luca", name: "Luca", imageName: "reader_luca", introSound: "luca_intro", borderColor: .clear)
]

struct ChooseReaderView: View {
    @AppStorage("selectedReaderID") var selectedReaderID: String = "Writer" // Default is Writer
    @State private var bouncingID: String? = nil

    var body: some View {
        VStack(spacing: 32) {
            Text("Hi, we are the readers. Choose one of us. ♥")
                .font(.custom("Noteworthy", size: 50))
                .multilineTextAlignment(.center)
                .padding(.top, 50)

            HStack(spacing: 70) {
                ForEach(readersEnglish) { reader in
                    Button(action: {
                        playIntro(for: reader)
                        selectedReaderID = reader.id // <---- Persist globally
                        withAnimation(.easeInOut(duration: 0.1)) { bouncingID = reader.id }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring()) { bouncingID = nil }
                        }
                    }) {
                        VStack {
                            Image(reader.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 300)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(reader.borderColor, lineWidth: 8)
                                )
                                .scaleEffect(bouncingID == reader.id ? 1.08 : 1.0)
                                .offset(y: bouncingID == reader.id ? -10 : 0)
                                .shadow(radius: 8)
                            Text(reader.name)
                                .font(.custom("Noteworthy", size: 40))
                                .padding(.top, 12)
                                .foregroundColor(.green)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .animation(
                        Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: true),
                        value: bouncingID == nil // subtle idle bounce
                    )
                }
            }
            
            // Reading mode selection
            VStack(spacing: 40) {
                Button("🔊 I want to hear the story") {
                    AppSettings.shared.readMode = .withVoice
                }
                .font(.title)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
                .foregroundColor(.white)

                Button("🙋 I’ll Read Myself") {
                    AppSettings.shared.readMode = .alone
                }
                .font(.title)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
                .foregroundColor(.white)
            }
            Spacer()
        }
        .background(
            Image("readers_bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }

    func playIntro(for reader: Readers) {
        SoundPlayer.playSound(named: reader.introSound)
    }
}
