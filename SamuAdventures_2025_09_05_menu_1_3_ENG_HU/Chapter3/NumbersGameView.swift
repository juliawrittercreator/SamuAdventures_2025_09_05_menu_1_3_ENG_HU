//
//  NumbersGameView.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 06..
//

import SwiftUI

struct NumbersGameView: View {
    // Number pairs and answers
    let numberPairs = [(2, 3), (4, 6), (1, 5)]
    let answerBubbles = [5, 6, 7, 8, 10, 11] // numbers to drag

    // State
    @State private var answersPlaced: [Int?] = [nil, nil, nil]
    @State private var showConfetti = false

    var body: some View {
        ZStack {
            // Background image (Page 8 English)
            Image("Ch3_Page08_EN") // Replace with your asset name
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Text("Let’s Play a Numbers Game!")
                    .font(.title)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)

                // Number sums with drop targets
                ForEach(0..<numberPairs.count, id: \.self) { index in
                    HStack {
                        Text("\(numberPairs[index].0) + \(numberPairs[index].1) =")
                            .font(.title2)
                            .padding(.leading)

                        ZStack {
                            Circle()
                                .strokeBorder(Color.blue, lineWidth: 3)
                                .frame(width: 70, height: 70)
                                .background(Color.white.opacity(0.8))

                            if let answer = answersPlaced[index] {
                                Text("\(answer)")
                                    .font(.title2)
                                    .foregroundColor(.green)
                            }
                        }
                        // Correct drag-and-drop handling
                        .onDrop(of: [.plainText], isTargeted: nil) { providers in
                            if let provider = providers.first {
                                _ = provider.loadObject(ofClass: NSString.self) { (item, error) in
                                    if let str = item as? String, let dragged = Int(str) {
                                        let correct = numberPairs[index].0 + numberPairs[index].1
                                        if dragged == correct {
                                            DispatchQueue.main.async {
                                                answersPlaced[index] = dragged
                                                checkCompletion()
                                            }
                                        }
                                    }
                                }
                            }
                            return true
                        }
                    }
                }

                Text("Drag the correct number bubble into the circle!")
                    .font(.headline)
                    .padding(.top)

                // Answer bubbles
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 20) {
                    ForEach(answerBubbles, id: \.self) { number in
                        Text("\(number)")
                            .font(.title2)
                            .frame(width: 70, height: 70)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                            .onDrag {
                                return NSItemProvider(object: String(number) as NSString)
                            }
                    }
                }
                .padding(.horizontal)
            }
            .padding()

            // Confetti overlay
            if showConfetti {
                VStack {
                    Text("🎉 Hooray! You did it! 🎉")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .transition(.scale)
                }
            }
        }
    }

    func checkCompletion() {
        if !answersPlaced.contains(nil) {
            withAnimation {
                showConfetti = true
            }
        }
    }
}

struct NumbersGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersGameView()
    }
}
