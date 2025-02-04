/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI

struct HistoricoPressaoView: View {
    @ObservedObject var vm: PressaoViewModel
    
    var body: some View {
        
        
        
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
        .navigationTitle("Histórico")
        
        .onAppear {
            vm.fetchPressoes()
        }
        
        
        
        
    }
}

#Preview {
    HistoricoPressaoView(vm: PressaoViewModel())
}
