//
//  SwiftUIView.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 30/01/25.
//

import SwiftUI

struct RemediosListView: View {
    
    @StateObject var vm = RemedioViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink("Adicionar Remédio", destination: AdicionarRemedio(vm: vm))
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        RemedioListComponent(vm: vm)
                    }
                }.navigationTitle("Remédios")
            }
        }
    }
}

#Preview {
    RemediosListView()
}
