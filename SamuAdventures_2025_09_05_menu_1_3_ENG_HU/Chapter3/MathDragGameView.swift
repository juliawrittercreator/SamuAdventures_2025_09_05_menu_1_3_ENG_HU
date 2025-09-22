//
//  MathDragGameView.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 20..
//

import SwiftUI

struct MathEquation: Identifiable {
    let id = UUID()
    let left: Int
    let right: Int
    let result: Int
    var answerPosition: CGPoint // Where the answer drop target is on the screen
}

// You can adjust these as needed to match your layout
let equations: [MathEquation] = [
    MathEquation(left: 2, right: 2, result: 4, answerPosition: CGPoint(x: 250, y: 150)),
    MathEquation(left: 6, right: 2, result: 8, answerPosition: CGPoint(x: 1000, y: 150)),
    MathEquation(left: 8, right: 6, result: 14, answerPosition: CGPoint(x: 1000, y: 350)),
    MathEquation(left: 8, right: 8, result: 16, answerPosition: CGPoint(x: 1000, y: 500)),
    MathEquation(left: 2, right: 4, result: 6, answerPosition: CGPoint(x: 1000, y: 650)),
]

let draggableNumbers = [2, 4, 6, 8, 14] // Add as many as you want, matching your circle images

struct MathDragGameView: View {
    @State private var answers: [Int?] = Array(repeating: nil, count: equations.count)
    @State private var circlePositions: [Int: CGSize] = [:] // Tracks the drag offset for each number
    @State private var usedNumbers: Set<Int> = []
    @State private var showConfetti: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background
                Image("Ch3_Page012_Hun")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // Equations and drop targets
                ForEach(Array(equations.enumerated()), id: \.element.id) { idx, eq in
                    VStack {
                        HStack(spacing: 16) {
                            Text("\(eq.left)")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                            Text("+")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.black)
                            Text("\(eq.right)")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                            Text("=")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.black)
                            ZStack {
                                if let answer = answers[idx] {
                                    Image("circle\(answer)")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .shadow(radius: 6)
                                } else {
                                    Circle()
                                        .strokeBorder(Color.black.opacity(0.3), lineWidth: 3)
                                        .frame(width: 80, height: 80)
                                }
                            }
                        }
                        .position(x: eq.answerPosition.x, y: eq.answerPosition.y)
                    }
                }

                // Draggable circled numbers
                ForEach(draggableNumbers, id: \.self) { number in
                    if !usedNumbers.contains(number) {
                        DraggableCircle(
                            number: number,
                            offset: circlePositions[number] ?? .zero,
                            onDragChanged: { value in
                                circlePositions[number] = value.translation
                            },
                            onDragEnded: { value in
                                // Check if dropped over any answer position
                                for (idx, eq) in equations.enumerated() {
                                    let answerPos = eq.answerPosition
                                    let dropLocation = CGPoint(
                                        x: (circlePositions[number]?.width ?? 0) + 100,
                                        y: (circlePositions[number]?.height ?? 0) + 100
                                    )
                                    // Adjust these hit test values as needed for your layout
                                    let distance = hypot(dropLocation.x - answerPos.x, dropLocation.y - answerPos.y)
                                    if distance < 80 && eq.result == number && answers[idx] == nil {
                                        // Correct answer and slot empty
                                        answers[idx] = number
                                        usedNumbers.insert(number)
                                        break
                                    }
                                }
                                circlePositions[number] = .zero
                            }
                        )
                        .position(x: CGFloat(150 + (number * 60) % 1000), y: CGFloat(700 + (number * 30) % 80))
                    }
                }

                // Congratulation and confetti
                if answers.allSatisfy({ $0 != nil }) {
                    ConfettiView()
                    VStack {
                        Text("🎉 Congratulations! 🎉")
                            .font(.system(size: 64, weight: .heavy, design: .rounded))
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(24)
                    }
                }
            }
        }
    }
}

struct DraggableCircle: View {
    let number: Int
    var offset: CGSize
    var onDragChanged: (DragGesture.Value) -> Void
    var onDragEnded: (DragGesture.Value) -> Void

    var body: some View {
        Image("circle\(number)")
            .resizable()
            .frame(width: 80, height: 80)
            .shadow(radius: 5)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged(onDragChanged)
                    .onEnded(onDragEnded)
            )
    }
}

// Simple confetti effect with circles and rectangles
struct ConfettiView: View {
    @State private var confetti = [ConfettiPiece]()

    var body: some View {
        ZStack {
            ForEach(confetti) { piece in
                piece.shape
                    .frame(width: piece.size, height: piece.size)
                    .foregroundColor(piece.color)
                    .position(piece.position)
                    .opacity(piece.opacity)
                    .animation(
                        Animation.linear(duration: piece.duration)
                            .repeatCount(1, autoreverses: false),
                        value: piece.position
                    )
            }
        }
        .onAppear {
            confetti = (0..<40).map { _ in ConfettiPiece.random }
        }
    }
}

struct ConfettiPiece: Identifiable {
    let id = UUID()
    let shape: AnyView
    let color: Color
    let position: CGPoint
    let opacity: Double
    let size: CGFloat
    let duration: Double

    static var random: ConfettiPiece {
        let shapes: [AnyView] = [
            AnyView(Circle()),
            AnyView(Rectangle()),
            AnyView(Capsule())
        ]
        let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink]
        let shape = shapes.randomElement()!
        let color = colors.randomElement()!
        let position = CGPoint(x: CGFloat.random(in: 80...1100), y: CGFloat.random(in: 0...600))
        let opacity = Double.random(in: 0.6...1)
        let size = CGFloat.random(in: 16...34)
        let duration = Double.random(in: 1.0...2.5)
        return ConfettiPiece(shape: shape, color: color, position: position, opacity: opacity, size: size, duration: duration)
    }
}
