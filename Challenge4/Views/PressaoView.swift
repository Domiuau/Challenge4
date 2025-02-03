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
    @State private var showAlert: Bool = false
    @State private var tituloAlert: String = ""
    @State private var mensagemAlert: String = ""
    @StateObject var vm: PressaoViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    HStack(alignment: .top) {
                        
                        Text("Como está a sua pressão hoje?")
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "info.circle")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.horizontal)
                    
                    
                    
                    VStack {
                        TextField("Sistólico", text: $inputTextS)
                            .keyboardType(.numberPad)
                            .font(.system(size: 50))
                            .onChange(of: inputTextS) { newValue in
                                sistolica = Int(newValue)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(height: 3)
                                    .opacity(0.44)
                                    .foregroundColor(.gray), alignment: .bottom
                            )
                        
                        Spacer().frame(height: 16)
                        
                        TextField("Diastólico", text: $inputTextD)
                            .keyboardType(.numberPad)
                            .font(.system(size: 50))
                            .onChange(of: inputTextD) { newValue in
                                diastolica = Int(newValue)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(height: 3)
                                    .opacity(0.44)
                                    .foregroundColor(.gray), alignment: .bottom
                            )
                    }
                    .padding()
                    
                    BotaoAcaoComponent(texto: "Salvar") {
                        
                        if let sistolica = sistolica, let diastolica = diastolica {
                            
                            if (sistolica < 80 || sistolica > 170) {
                                
                                exibirAlert(titulo: "Valores inválidos", mensagem: "A pressão sistólica deve estar entre 80 e 170.")
                                return
                            } else if (diastolica < 40 || diastolica > 130) {
                                
                                exibirAlert(titulo: "Valores inválidos", mensagem: "A pressão diastólica deve estar entre 40 e 130.")
                                return
                            }
                            
                            let dataAtual = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                            
                            vm.addPressao(diastolica: diastolica, sistolica: sistolica, data: dataAtual)
                            exibirAlert(titulo: "A sua pressão arterial foi registrada com sucesso!", mensagem: "Data: \(dateFormatter.string(from: dataAtual)) - Pressão Arterial: \(sistolica)/\(diastolica)")
                        }
                    }
                    
                }
                
                Text("Histórico")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                GraficoPressaoComponent(registrosPressoes: vm.entidadeSalvasPressao)
                    .padding()
                
                NavigationLink(destination: HistoricoPressaoView(vm: vm)) {
                    BotaoAcaoComponent(texto: "Mais Detalhes", action: nil)
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Pressão")
        }
        .onAppear {
            vm.fetchPressoes()
        }
        
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(tituloAlert),
                message: Text(mensagemAlert),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: showAlert) { newValue in
            if !newValue {
                inputTextS = ""
                inputTextD = ""
                
            }
        }
    }
    
    func exibirAlert(titulo: String, mensagem: String) {
        tituloAlert = titulo
        mensagemAlert = mensagem
        showAlert.toggle()
    }
}

#Preview {
    PressaoView(vm: PressaoViewModel())
}
