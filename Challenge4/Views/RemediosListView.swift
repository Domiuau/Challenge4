//
//  SwiftUIView.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 30/01/25.
//

import SwiftUI

struct RemediosListView: View {
    
    @StateObject var vm = RemedioViewModel()
    @State var isShowing: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink("Adicionar Remédio", destination: AdicionarRemedio())
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.nomeRemedio ?? "SEM NOME")
                        Text(entity.dosagem ?? "SEM DOSAGEM")
                        Text(entity.horario ?? "SEM HORARIO")
                    }
                }.navigationTitle("Remédios")
            }
        }
    }
}

#Preview {
    RemediosListView()
}
