//
// PuzzleLakeView.swift
//
//
//  Created by Eva Julia Boros on 2025. 09. 16..
//

//
// PuzzleLakeView.swift
//
//
//  Created by Eva Julia Boros on 2025. 09. 16..
//

import SwiftUI
import AVFoundation

struct PuzzlePiece: Identifiable {
    let id: Int
    let imageName: String
    let startCenter: CGPoint   // Initial scrambled position
    let startSize: CGSize      // Size when not placed
    let snapCenter: CGPoint    // Center of grid cell
    let placedSize: CGSize     // Size when placed
    var isPlaced: Bool = false
    var dragOffset: CGSize = .zero
}

struct PuzzleLakeView: View {
    // Layout constants
    let gridSize: CGFloat = 600
    let gridColumns = 3
    let gridRows = 3
    let gridOrigin: CGPoint = CGPoint(x: 339, y: 80)
    let snapDistance: CGFloat = 60

    let puzzleBgImage = "Puzzle_lake_main"
    let pageBgImage = "Ch1_Page04_EN"

    let viewWidth: CGFloat = 1277
    let viewHeight: CGFloat = 768

    @State private var pieces: [PuzzlePiece] = []
    @State private var completed = false
    @State private var showPuzzle = true
    @State private var bgOpacity: Double = 0.35
    @State private var audioPlayer: AVAudioPlayer?
    @State private var confettiTrigger = false
    @State private var showCongratulations = false

    // For narration
    @AppStorage("selectedReaderID") var selectedReaderID: String = "Writer"
    @AppStorage("readMode") var readMode: String = "withVoice" // "withVoice" or "alone"

    var narrationMap: [String: String] = [
        "Writer": "Ch1_Page04_Writer_EN",
        "Mia":    "Ch1_Page04_Mia_EN",
        "Luca":   "Ch1_Page04_Luca_EN"
        // Add more if needed
    ]

    var body: some View {
        ZStack {
            // 1. Page background
            Image(pageBgImage)
                .resizable()
                .scaledToFill()
                .opacity(bgOpacity)
                .frame(width: viewWidth, height: viewHeight)
                .ignoresSafeArea()
                .zIndex(0)

            // 2. Puzzle grid background & pieces
            if showPuzzle {
                Image(puzzleBgImage)
                    .resizable()
                    .frame(width: gridSize, height: gridSize)
                    .opacity(0.65)
                    .position(x: gridOrigin.x + gridSize/2, y: gridOrigin.y + gridSize/2)
                    .zIndex(1)

                PuzzleGridOverlay(size: gridSize, origin: gridOrigin)
                    .zIndex(2)

                // Puzzle pieces
                ForEach($pieces) { $piece in
                    let pieceSize = piece.isPlaced ? piece.placedSize : piece.startSize

                    Image(piece.imageName)
                        .resizable()
                        .frame(width: pieceSize.width, height: pieceSize.height)
                        .position(
                            piece.isPlaced
                                ? piece.snapCenter
                                : CGPoint(
                                    x: piece.startCenter.x + piece.dragOffset.width,
                                    y: piece.startCenter.y + piece.dragOffset.height
                                )
                        )
                        .gesture(
                            piece.isPlaced ? nil :
                                DragGesture()
                                .onChanged { value in
                                    piece.dragOffset = value.translation
                                }
                                .onEnded { value in
                                    let dropPoint = CGPoint(
                                        x: piece.startCenter.x + value.translation.width,
                                        y: piece.startCenter.y + value.translation.height
                                    )
                                    if distance(dropPoint, piece.snapCenter) < snapDistance {
                                        piece.isPlaced = true
                                        piece.dragOffset = .zero
                                        checkCompletion()
                                    } else {
                                        piece.dragOffset = .zero
                                    }
                                }
                        )
                        .zIndex(piece.isPlaced ? 3 : 4)
                }
            }

            // 3. Confetti and congratulations
            // Confetti is shown above everything
            if completed {
                EmojiConfettiView(trigger: $confettiTrigger)
                    .zIndex(200)
            }
            if showCongratulations {
                VStack {
                    Text("🎉 Congratulations! 🎉")
                        .font(.custom("Noteworthy", size: 50) )
                        .foregroundColor(.green)
                        .bold()
                        .padding(.top, 300)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.clear)
                .zIndex(201)
                .transition(.scale)
            }
        }
        .frame(width: viewWidth, height: viewHeight)
        .onAppear {
            let cell = gridSize / 3.0
            // Calculate snap centers for grid cells (top-left to bottom-right)
            var snapPoints: [CGPoint] = []
            for row in 0..<3 {
                for col in 0..<3 {
                    let center = CGPoint(
                        x: gridOrigin.x + CGFloat(col) * cell + cell/2,
                        y: gridOrigin.y + CGFloat(row) * cell + cell/2
                    )
                    snapPoints.append(center)
                }
            }
            // Off-grid starting positions for visual effect (spread around the grid)
            let starts: [CGPoint] = [
                CGPoint(x: gridOrigin.x - 120, y: gridOrigin.y + gridSize - 80), // piece 1
                CGPoint(x: gridOrigin.x + gridSize + 110, y: gridOrigin.y + 10), // piece 2
                CGPoint(x: gridOrigin.x + gridSize/110, y: gridOrigin.y + gridSize - 300), // piece 3
                CGPoint(x: gridOrigin.x - 120, y: gridOrigin.y + 90), // piece 4
                CGPoint(x: gridOrigin.x + gridSize + 100, y: gridOrigin.y + gridSize/2), // piece 5
                CGPoint(x: gridOrigin.x + 50, y: gridOrigin.y - 60), // piece 6
                CGPoint(x: gridOrigin.x + gridSize + 60, y: gridOrigin.y + gridSize + 90), // piece 7
                CGPoint(x: gridOrigin.x + gridSize/2, y: gridOrigin.y - 1), // piece 8
                CGPoint(x: gridOrigin.x + gridSize - 40, y: gridOrigin.y - 1) // piece 9
            ]
            // Example: per-piece size (customize these for your needs)
            let startSizes: [CGSize] = [
                CGSize(width: 300, height: 320), // piece 1
                CGSize(width: 310, height: 320), // piece 2
                CGSize(width: 300, height: 320), // piece 3
                CGSize(width: 316, height: 320), // piece 4
                CGSize(width: 300, height: 320), // piece 5
                CGSize(width: 316, height: 320), // piece 6
                CGSize(width: 300, height: 320), // piece 7
                CGSize(width: 310, height: 330), // piece 8
                CGSize(width: 300, height: 320)  // piece 9
            ]
            let placedSizes: [CGSize] = [
                CGSize(width: 326, height: 325), // piece 1
                CGSize(width: 326, height: 320), // etc...
                CGSize(width: 316, height: 325 ), // piece 3
                CGSize(width: 336, height: 310),  // piece 4
                CGSize(width: 310, height: 320),  // piece 5
                CGSize(width: 316, height: 325),
                CGSize(width: 326, height: 325), // piece 7
                CGSize(width: 305, height: 325), // piece 8
                CGSize(width: 300, height: 320) // piece 9
            ]
            pieces = (0..<9).map { i in
                PuzzlePiece(
                    id: i,
                    imageName: "lake_piece_\(i+1)",
                    startCenter: starts[i],
                    startSize: startSizes[i],
                    snapCenter: snapPoints[i],
                    placedSize: placedSizes[i]
                )
            }
            completed = false
            showPuzzle = true
            bgOpacity = 0.35
            showCongratulations = false
        }
    }

    private func checkCompletion() {
        if pieces.allSatisfy({ $0.isPlaced }) {
            withAnimation {
                completed = true
                showCongratulations = true
            }
            confettiTrigger = true // Only set the trigger here!
            playCheers()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    showPuzzle = false
                    bgOpacity = 1.0
                    showCongratulations = false
                }
                playNarrationIfNeeded()
            }
        }
    }

    private func playCheers() {
        if let url = Bundle.main.url(forResource: "cheers_task_complete", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing cheers_task_complete.mp3: \(error)")
            }
        }
    }

    private func playNarrationIfNeeded() {
        guard readMode == "withVoice", let narrationSound = narrationMap[selectedReaderID], !narrationSound.isEmpty else {
            return
        }
        if let url = Bundle.main.url(forResource: narrationSound, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing narration: \(error)")
            }
        }
    }

    private func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2))
    }
}

// Draws a 3x3 white grid overlay
struct PuzzleGridOverlay: View {
    let size: CGFloat
    let origin: CGPoint
    var body: some View {
        Path { path in
            // Vertical lines
            for i in 0...3 {
                let x = origin.x + CGFloat(i) * size/3
                path.move(to: CGPoint(x: x, y: origin.y))
                path.addLine(to: CGPoint(x: x, y: origin.y + size))
            }
            // Horizontal lines
            for i in 0...3 {
                let y = origin.y + CGFloat(i) * size/3
                path.move(to: CGPoint(x: origin.x, y: y))
                path.addLine(to: CGPoint(x: origin.x + size, y: y))
            }
        }
        .stroke(Color.white, lineWidth: 4)
        .opacity(0.7)
        .zIndex(2)
    }
}
