//
//  TabBarComponent.swift
//  Challenge4
//
//  Created by JOAO VICTOR FARIAS TEIXEIRA on 30/01/25.
//

import SwiftUI

struct TabBarComponent: View {
    
    let pressaoViewModel: PressaoViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                PressaoView(vm: pressaoViewModel)
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Pressão")
            }
            
            NavigationStack {
                RemediosListView()
            }
            .tabItem {
                Image(systemName: "pill.fill")
                Text("Remédios")
            }
            
            NavigationStack {
                SobreView()
            }
            .tabItem {
                Image(systemName: "info.circle")
                Text("Sobre")
            }
        }
    }
}

#Preview {
    TabBarComponent(pressaoViewModel: PressaoViewModel())
}
