//
//  SwiftUIView.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 30/01/25.
//

import SwiftUI

struct RemediosListView: View {
    
    @StateObject var vm = RemedioCoreDataViewModel()
    @State var isShowing: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isShowing = true
                }, label: {
                    Text("Adicionar Remédio")
                        .font(.title)
                        .foregroundStyle(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                })
            }
            .sheet(item: <#T##Binding<Identifiable?>#>, content: <#T##(Identifiable) -> View#>)
        }
    }
}

#Preview {
    RemediosListView()
}
