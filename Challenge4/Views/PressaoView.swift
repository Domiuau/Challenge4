//
//  ContentView.swift
//  Challenge4
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/01/25.
//

import SwiftUI

struct PressaoView: View {
    @State private var sistolica: Int? = nil
    @State private var diastolica: Int? = nil
    @State private var inputTextS: String = ""
    @State private var inputTextD: String = ""
    @StateObject var vm = PressaoViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Como está a sua pressão hoje?")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                VStack {
                    TextField("Sistólico", text: $inputTextS)
                        .keyboardType(.numberPad)
                        .font(.system(size: 50))
                        .onChange(of: inputTextS) { newValue in
                            sistolica = Int(newValue)
                        }
                    
                    Spacer().frame(height: 10)
                    
                    TextField("Diastólico", text: $inputTextD)
                        .keyboardType(.numberPad)
                        .font(.system(size: 50))
                        .onChange(of: inputTextD) { newValue in
                            diastolica = Int(newValue)
                        }
                }
                .padding()
                
                BotaoAcaoComponent(texto: "Salvar") {
                    if let sistolica = sistolica, let diastolica = diastolica {
                        vm.addPressao(diastolica: diastolica, sistolica: sistolica)
                        inputTextS = ""
                        inputTextD = ""
                    }
                }
                
                Divider()
                    .padding()
                
                Text("Histórico de Pressões")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                List {
                    ForEach(vm.entidadeSalvas, id: \.self) { pressao in
                        VStack(alignment: .leading) {
                            Text("Sistólica: \(pressao.sistolica)")
                            Text("Diastólica: \(pressao.diastolica)")
                            Text("Data: \(pressao.data?.formatted(date: .abbreviated, time: .shortened) ?? "Sem data")")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: vm.deletePressao)
                }
                .frame(height: 300)
            }
            .padding()
        }
        .navigationTitle("Pressão")
        .onAppear {
            vm.fetchPressoes()
        }
    }
}


#Preview {
    PressaoView()
}
