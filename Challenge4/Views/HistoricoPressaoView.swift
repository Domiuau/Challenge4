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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Picker("Ordenar por", selection: $vm.ordenacaoAscendente) {
                Text("Mais recente").tag(false)
                Text("Mais antigo").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List {
                ForEach(vm.entidadeSalvasPressao, id: \.self) { pressao in
                    VStack(alignment: .leading) {
                        Text("\(pressao.sistolica)/\(pressao.diastolica)")
                            .font(.title)
                            .foregroundColor(vm.corSituacaoPressao(situacao: vm.situacaoPressao(sistolica: Int(pressao.sistolica))))
                            .bold()
                        
                        Spacer().frame(height: 5)
                        
                        HStack {
                            Text(vm.situacaoPressao(sistolica: Int(pressao.sistolica)))
                                .font(.headline)
                                .foregroundColor(vm.corSituacaoPressao(situacao: vm.situacaoPressao(sistolica: Int(pressao.sistolica))))
                            Spacer()
                            Text(pressao.data != nil ? vm.formatarData(pressao.data!) : "Sem data")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    vm.deletePressao(index: indexSet)
                    if(vm.entidadeSalvasPressao.isEmpty) {
                        dismiss()
                    }
                })
            }
            .listStyle(InsetListStyle())
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Histórico")
        .onAppear {
            vm.fetchPressoes()
        }
    }
}


#Preview {
    HistoricoPressaoView(vm: PressaoViewModel())
}
