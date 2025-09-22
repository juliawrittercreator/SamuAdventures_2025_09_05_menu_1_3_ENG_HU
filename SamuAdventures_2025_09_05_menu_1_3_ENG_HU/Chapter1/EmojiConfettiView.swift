//
//  EmojiConfettiView.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 15..
//

import SwiftUI

struct EmojiConfettiView: View {
    let emojis = ["✨"]
    let confettiCount = 150
    @Binding var trigger: Bool

    @State private var confettiItems: [ConfettiItem] = []
    @State private var animate = false

    enum ConfettiType {
        case emoji(String)
        case image(String) // name in Assets
    }

    struct ConfettiItem: Identifiable {
        let id = UUID()
        let type: ConfettiType
        let angle: Double      // direction in degrees
        let delay: Double      // random delay before animation starts
        let speed: Double      // animation speed
        let distance: CGFloat  // how far it will travel
        let size: CGFloat
    }

    var body: some View {
        ZStack {
            ForEach(confettiItems) { item in
                confettiView(for: item)
                    .opacity(animate ? 0 : 1)
                    .offset(
                        x: animate ? cos(item.angle * .pi / 180) * item.distance : 0,
                        y: animate ? sin(item.angle * .pi / 180) * item.distance : 0
                    )
                    .animation(
                        .easeOut(duration: item.speed)
                            .delay(item.delay),
                        value: animate
                    )
            }
        }
        .onChange(of: trigger) { newValue in
            if newValue {
                let imageNames = [
                    "confetti_pink",
                    "confetti_yellow",
                    "confetti_orange",
                    "confetti_red",
                    "confetti_blue",
                    "confetti_azur",
                    "confetti_green"
                ]
                
                // Generate confetti items
                confettiItems = (0..<confettiCount).map { _ in
                    if Bool.random() {
                        return ConfettiItem(
                            type: .image(imageNames.randomElement()!),
                            angle: Double.random(in: 0..<360),
                            delay: Double.random(in: 0...0.3),
                            speed: Double.random(in: 1.0...2.0),
                            distance: CGFloat.random(in: 150...350),
                            size: CGFloat.random(in: 20...44)
                        )
                    } else {
                        return ConfettiItem(
                            type: .emoji(emojis.randomElement()!),
                            angle: Double.random(in: 0..<360),
                            delay: Double.random(in: 0...0.3),
                            speed: Double.random(in: 1.0...2.0),
                            distance: CGFloat.random(in: 150...350),
                            size: CGFloat.random(in: 50...55)
                        )
                    }
                }

                // Start animation
                withAnimation {
                    animate = true
                }

                // Cleanup after animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    animate = false
                    confettiItems = []
                    trigger = false
                }
            }
        }
    }

    @ViewBuilder
    private func confettiView(for item: ConfettiItem) -> some View {
        switch item.type {
        case .emoji(let symbol):
            Text(symbol)
                .font(.system(size: item.size))
        case .image(let name):
            Image(name)
                .resizable()
                .frame(width: item.size, height: item.size)
        }
    }
}
