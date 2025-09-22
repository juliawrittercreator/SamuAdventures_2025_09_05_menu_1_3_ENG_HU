//
//  ScratchHedgehogViewHUN.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 17..
//

import SwiftUI

struct ScratchHedgehogViewHUN: View {
    @State private var points: [CGPoint] = []
    let scratchRadius: CGFloat = 80
    @State private var showConfetti = false
    @State private var scratched = false   // tracks if scratching started

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // 1. Background image (hidden image)
                Image("Ch1_Page02_HU")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .ignoresSafeArea()

                // 2. Cover image with mask
                Image("Ch1_Page02_Cover")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .mask(
                        ScratchMaskView(points: points, radius: scratchRadius)
                    )

                // 3. Confetti overlay
                EmojiConfettiView(trigger: $showConfetti)

                // 4. Custom "Find Samu" image (only visible until scratching starts)
                if !scratched {
                    BouncingImageView(imageName: "Latod Samut")
                        .frame(width: 190, height: 190) // adjust size as needed
                        .padding()
                        .position(x: geo.size.width - 910, y: 500) // top-right corner
                        .transition(.opacity) // smooth fade-out
                }
            }
            // --- Changed from .gesture(...) to .simultaneousGesture(...) ---
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let local = CGPoint(x: value.location.x, y: value.location.y)
                        points.append(local)

                        // Hide "Find Samu" when first scratch happens
                        if !scratched {
                            withAnimation(.easeOut(duration: 0.5)) {
                                scratched = true
                            }
                        }

                        // Trigger confetti every 10 points
                        if points.count % 10 == 0 {
                            showConfetti = true
                        }
                    }
            )
        }
    }
}

struct ScratchMaskViewHUN: View {
    var points: [CGPoint]
    var radius: CGFloat

    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.white))
                for point in points {
                    let circle = Path(ellipseIn: CGRect(
                        x: point.x - radius,
                        y: point.y - radius,
                        width: radius * 2,
                        height: radius * 2)
                    )
                    context.fill(circle, with: .color(.black))
                }
            }
            .compositingGroup()
            .luminanceToAlpha()
        }
    }
}

struct BouncingImageViewHUN: View {
    let imageName: String
    @State private var bounce = false

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .scaleEffect(bounce ? 1.1 : 0.9)
            .offset(y: bounce ? -6 : 6)
            .animation(
                .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                value: bounce
            )
            .onAppear {
                bounce = true
            }
    }
}
