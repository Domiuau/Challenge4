//
//  HistoricoPressaoView.swift
//  Challenge4
//
//  Created by JOAO VICTOR FARIAS TEIXEIRA on 31/01/25.
//

import SwiftUI

struct HistoricoPressaoView: View {
    @ObservedObject var vm = PressaoViewModel()
    
    var body: some View {
        Text("Histórico de Pressões")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        List {
            ForEach(vm.entidadeSalvasPressao, id: \.self) { pressao in
                VStack(alignment: .leading) {
                    Text("\(pressao.sistolica)/\(pressao.diastolica)")
                        .font(.title)
                    HStack {
                        Text(vm.situacaoPressao(sistolica: Int(pressao.sistolica), diastolica: Int(pressao.diastolica)))
                            .font(.title2)
                        Spacer()
                        Text(pressao.data != nil ? vm.formatarData(pressao.data!) : "Sem data")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: vm.deletePressao)
        }
        .onAppear {
            vm.fetchPressoes()
        }
    }
}

#Preview {
    HistoricoPressaoView()
}
