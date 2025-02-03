//
//  HistoricoPressaoView.swift
//  Challenge4
//
//  Created by JOAO VICTOR FARIAS TEIXEIRA on 31/01/25.
//

import SwiftUI

struct HistoricoPressaoView: View {
    @ObservedObject var vm: PressaoViewModel
    
    var body: some View {
        Text("Histórico")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        List {
            ForEach(vm.entidadeSalvasPressao, id: \.self) { pressao in
                VStack(alignment: .leading) {
                    Text("\(pressao.sistolica)/\(pressao.diastolica)")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                        .frame(height: 5)
                    
                    HStack {
                        Text(vm.situacaoPressao(sistolica: Int(pressao.sistolica), diastolica: Int(pressao.diastolica)))
                            .font(.headline)
                        Spacer()
                        Text(pressao.data != nil ? vm.formatarData(pressao.data!) : "Sem data")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: vm.deletePressao)
        }
        .listStyle(InsetListStyle())
        .scrollContentBackground(.hidden)
        
        .onAppear {
            vm.fetchPressoes()
        }
    }
}

#Preview {
    HistoricoPressaoView(vm: PressaoViewModel())
}
