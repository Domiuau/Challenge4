/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI

struct TabBarComponent: View {
    
    let pressaoViewModel: PressaoViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                PressaoView(vm: pressaoViewModel)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
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
