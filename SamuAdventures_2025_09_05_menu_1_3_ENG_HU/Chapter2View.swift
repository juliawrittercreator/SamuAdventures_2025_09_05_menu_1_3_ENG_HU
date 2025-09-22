//
// import SwiftUI

import SwiftUI

struct Chapter2View: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
            
            Button(action: {
                print("Button tapped!")
            }) {
                Text("Tap Me")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main_Menu()
            .previewDevice("iPad Pro (11-inch)")
    }
}
