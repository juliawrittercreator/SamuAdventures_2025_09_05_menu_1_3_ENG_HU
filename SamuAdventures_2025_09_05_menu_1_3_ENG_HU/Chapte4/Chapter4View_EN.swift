//
//  Chapter4View_EN.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HU
//
//  Created by Eva Julia Boros on 2025. 09. 06..
//

import SwiftUI

struct Chapter4View_EN: View {
    @Environment(\.dismiss) var dismiss  // allows going back


    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Page TabView
            TabView {
                Image("Ch4_Page01_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()

                Image("Ch4_Page02_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()

                Image("Ch4_Page03_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page04_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page05_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page06_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page07_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page08_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page09_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page010_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page011_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page012_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page013_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page014_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Image("Ch4_Page015_EN")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
              
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
       
        
    }
}
