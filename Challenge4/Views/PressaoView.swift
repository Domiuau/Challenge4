/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI

struct PressaoView: View {
    @State private var sistolica: Int? = nil
    @State private var diastolica: Int? = nil
    @State private var inputTextS: String = ""
    @State private var inputTextD: String = ""
    @State private var showAlert: Bool = false
    @State private var tituloAlert: String = ""
    @State private var showSheet: Bool = false
    @State private var mensagemAlert: String = ""
    @State var opcaoSelecionada = 0
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
                            
                            Button(action: {
                                
                                showSheet.toggle()
                            }, label: {
                                Image(systemName: "info.circle")
                                    .font(.title)
                                    .foregroundColor(.preto)
                            })
                            
                            
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            VStack {
                                TextField("Sistólica", text: $inputTextS)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 40))
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
                                
                                TextField("Diastólica", text: $inputTextD)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 40))
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
                            .padding([.bottom, .horizontal])
                        }
                        .padding(.trailing, 150)
                        
                        BotaoAcaoComponent(texto: "Salvar", action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            salvarPressao()
                        }, desabilitado: inputTextS == "" || inputTextD == "")
                        
                    }
                    
                    
                    Text("Histórico")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Picker("Opções", selection: $opcaoSelecionada) {
                        Text("Sistólica").tag(0)
                        Text("Diastólica").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    GraficoPressaoComponent(registrosPressoes: vm.entidadeSalvasPressao, tipoDePressao: $opcaoSelecionada)
                        .padding(.horizontal)
                    
                    if (vm.entidadeSalvasPressao.isEmpty) {
                        BotaoAcaoComponent(texto: "Mais Detalhes", action: nil, desabilitado: true)
                    } else {
                        NavigationLink(destination: HistoricoPressaoView(vm: vm)) {
                            BotaoAcaoComponent(texto: "Mais Detalhes", action: nil)
                        }
                        .padding([.bottom, .horizontal])
                    }
                    .padding(.trailing, 150)
                    
                    BotaoAcaoComponent(texto: "Salvar", action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        salvarPressao()
                    }, desabilitado: inputTextS == "" || inputTextD == "")
                    
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                
                
                Text("Histórico")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Picker("Opções", selection: $opcaoSelecionada) {
                    Text("Sistólica").tag(0)
                    Text("Diastólica").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                GraficoPressaoComponent(registrosPressoes: vm.entidadeSalvasPressao, tipoDePressao: $opcaoSelecionada)
                    .padding(.horizontal)
                
                if (vm.entidadeSalvasPressao.isEmpty) {
                    BotaoAcaoComponent(texto: "Mais Detalhes", action: nil, desabilitado: true)
                        .padding(.vertical)
                } else {
                    NavigationLink(destination: HistoricoPressaoView(vm: vm)) {
                        BotaoAcaoComponent(texto: "Mais Detalhes", action: nil)
                            .padding(.vertical)
                        
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .scrollIndicators(.hidden)
                .navigationTitle("Pressão")
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
        .sheet(isPresented: $showSheet, content: {
            VStack {
                
                
                Button(action: {
                    showSheet = false
                }, label: {
                    Text("OK")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.accentColor)
                        .bold()
                })
                
                Spacer()
                
                Text("O que é a pressão sistólica e diastólica?")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title)
                    .padding(.vertical)
                    .bold()
                
                Text("A pressão arterial é composta por dois valores: a sistólica, que é a pressão quando o coração se contrai, e a diastólica, que é a pressão quando o coração está em repouso")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("[(OMRON, 2025).](https://omronbrasil.com/o-que-e-pressao-arterial-sistolica-2/?srsltid=AfmBOopI9ifoLXgY3bw7amnoXYSBRGwH15MhxYPqf_ZsfTXqFbbnQECp)")
                    .underline()
                
                
                Image("medidorDePressao")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    
                    Text("• SIS = Sistólica")
                        .foregroundColor(.vinhoBotoes)
                        .padding(.leading, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .font(.title3)
                    
                    Spacer()
                    
                    Text("• DIA = Diastólica")
                        .foregroundColor(.batommorto)
                        .padding(.leading, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .font(.title3)
                }
                
                
                
                
                
                
                
                
                
                Spacer()
                
                
                
            }.padding()
        })
        .onChange(of: showAlert) { newValue in
            if !newValue {
                inputTextS = ""
                inputTextD = ""
                
            }
            
        }
    }
    
    func salvarPressao() {
        
        if let sistolica = sistolica, let diastolica = diastolica {
            
            if (sistolica < PressaoViewModel.MIN_SISTOLICO || sistolica > PressaoViewModel.MAX_SISTOLICO) {
                
                exibirAlert(titulo: "Valores inválidos", mensagem: "A pressão sistólica deve estar entre \(PressaoViewModel.MIN_SISTOLICO) e \(PressaoViewModel.MAX_SISTOLICO).")
                return
            } else if (diastolica < PressaoViewModel.MIN_DIASTOLICO || diastolica > PressaoViewModel.MAX_DIASTOLICO) {
                
                exibirAlert(titulo: "Valores inválidos", mensagem: "A pressão diastólica deve estar entre \(PressaoViewModel.MIN_DIASTOLICO) e \(PressaoViewModel.MAX_DIASTOLICO).")
                return
            }
            
            let dataAtual = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
            
            vm.addPressao(diastolica: diastolica, sistolica: sistolica, data: dataAtual)
            exibirAlert(titulo: "A sua pressão arterial foi registrada com sucesso!", mensagem: "Data: \(dateFormatter.string(from: dataAtual)) - Pressão Arterial: \(sistolica)/\(diastolica)")
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
