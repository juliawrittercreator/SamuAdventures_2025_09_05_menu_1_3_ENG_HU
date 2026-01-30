//
//  DrawingCanvasView.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by GitHub Copilot on 2026. 01. 30..
//

import SwiftUI

struct DrawingLine {
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
}

struct DrawingCanvasView: View {
    @State private var currentLine = DrawingLine(points: [], color: .black, lineWidth: 5)
    @State private var lines: [DrawingLine] = []
    @State private var selectedColorIndex: Int = 0
    @State private var lineWidth: CGFloat = 5
    
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) var dismiss
    
    let availableColors: [Color] = [
        .black, .red, .blue, .green, .orange, .purple, .pink, .yellow,
        Color(red: 139/255, green: 69/255, blue: 19/255), // brown
        Color(red: 128/255, green: 128/255, blue: 128/255)  // gray
    ]
    
    var selectedColor: Color {
        availableColors[selectedColorIndex]
    }
    
    // Helper function to create path from points
    private func createPath(from points: [CGPoint]) -> Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }
        path.move(to: firstPoint)
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        return path
    }
    
    var body: some View {
        ZStack {
            // Background
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top toolbar
                HStack {
                    // Back button
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text(LocalizedText.text(for: "back", lang: languageManager.currentLanguage))
                        }
                        .font(.custom("Noteworthy", size: 20))
                        .foregroundColor(Color(red: 49/255, green: 94/255, blue: 38/255))
                        .padding()
                    }
                    
                    Spacer()
                    
                    Text(LocalizedText.text(for: "drawing", lang: languageManager.currentLanguage))
                        .font(.custom("Noteworthy", size: 32))
                        .bold()
                        .foregroundColor(Color(red: 49/255, green: 94/255, blue: 38/255))
                    
                    Spacer()
                    
                    // Clear button
                    Button(action: {
                        lines.removeAll()
                        currentLine.points.removeAll()
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text(LocalizedText.text(for: "clear", lang: languageManager.currentLanguage))
                        }
                        .font(.custom("Noteworthy", size: 20))
                        .foregroundColor(.red)
                        .padding()
                    }
                }
                .frame(height: 80)
                .background(.ultraThinMaterial)
                
                // Drawing canvas
                ZStack {
                    // Canvas background with slight texture
                    Rectangle()
                        .fill(Color(white: 0.98))
                        .border(Color.gray.opacity(0.3), width: 2)
                    
                    // Drawing area
                    Canvas { context, size in
                        for line in lines {
                            let path = createPath(from: line.points)
                            context.stroke(
                                path,
                                with: .color(line.color),
                                lineWidth: line.lineWidth
                            )
                        }
                        
                        // Draw current line
                        if !currentLine.points.isEmpty {
                            let path = createPath(from: currentLine.points)
                            context.stroke(
                                path,
                                with: .color(currentLine.color),
                                lineWidth: currentLine.lineWidth
                            )
                        }
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let point = value.location
                                currentLine.points.append(point)
                            }
                            .onEnded { _ in
                                if !currentLine.points.isEmpty {
                                    lines.append(currentLine)
                                }
                                currentLine = DrawingLine(
                                    points: [],
                                    color: selectedColor,
                                    lineWidth: lineWidth
                                )
                            }
                    )
                }
                .padding()
                
                // Color picker toolbar
                VStack(spacing: 12) {
                    // Color selection
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(availableColors.indices, id: \.self) { index in
                                let color = availableColors[index]
                                Circle()
                                    .fill(color)
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedColorIndex == index ? Color.blue : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        selectedColorIndex = index
                                        currentLine.color = selectedColor
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Line width selector
                    HStack {
                        Text(LocalizedText.text(for: "line_width", lang: languageManager.currentLanguage))
                            .font(.custom("Noteworthy", size: 18))
                            .foregroundColor(Color(red: 49/255, green: 94/255, blue: 38/255))
                        
                        Slider(value: $lineWidth, in: 2...20, step: 1)
                            .frame(width: 200)
                            .onChange(of: lineWidth) { oldValue, newValue in
                                currentLine.lineWidth = newValue
                            }
                        
                        Text("\(Int(lineWidth))")
                            .font(.custom("Noteworthy", size: 18))
                            .foregroundColor(Color(red: 49/255, green: 94/255, blue: 38/255))
                            .frame(width: 40)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 140)
                .background(.ultraThinMaterial)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            currentLine.color = selectedColor
            currentLine.lineWidth = lineWidth
        }
    }
}

// MARK: - Preview
#Preview {
    DrawingCanvasView()
        .environmentObject(LanguageManager())
}
