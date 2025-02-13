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
    @State var filtroSelecionado: Bool = true
    
    var body: some View {
        VStack {
            Picker("Ordenar por", selection: $filtroSelecionado) {
                Text("Mais recente").tag(true)
                Text("Mais antigo").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List {
                ForEach(filtroSelecionado ? vm.pressoes.reversed() : vm.pressoes, id: \.self) { pressao in
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
                            Text(pressao.data != nil ? PressaoViewModel.formatarData(pressao.data) : "Sem data")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    vm.deletePressao(index: filtroSelecionado ? indexSet : vm.pressoes.count - 1 - indexSet)
                    if(vm.pressoes.isEmpty) {
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
