/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI
//so para dar commit dps deleta
struct PressaoView: View {
    @Environment(\.modelContext) var modelContextPressao
    @State private var sistolica: Int? = nil
    @State private var diastolica: Int? = nil
    @State private var inputTextS: String = ""
    @State private var inputTextD: String = ""
    @State private var showAlert: Bool = false
    @State private var tituloAlert: String = ""
    @State private var showSheet: Bool = false
    @State private var mensagemAlert: String = ""
    @State var opcaoSelecionada = 0
    @ObservedObject var vm: PressaoViewModel
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                VStack {

                    Text("Como está a sua pressão?")
                        .font(.title)
                        .padding(.horizontal)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        VStack {
                            
                            TextFieldInputPressaoComponent(inputText: $inputTextS, numeroInserido: $sistolica, textoPadrao: "Ex: 120")
                            
                            Spacer().frame(height: 16)
                            
                            TextFieldInputPressaoComponent(inputText: $inputTextD, numeroInserido: $diastolica, textoPadrao: "Ex: 80")
                            
                        }
                        .padding([.bottom, .horizontal])
                    }
                    .padding(.trailing, 180)
                    
                    BotaoAcaoComponent(texto: "Salvar", action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        salvarPressao()
                    }, desabilitado: inputTextS == "" || inputTextD == ""
                    )
                    .padding(.top, 4)
                    
                }
                
                Text("Histórico")
                    .padding(.horizontal)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Picker("Opções", selection: $opcaoSelecionada) {
                    Text("Sistólica").tag(0)
                    Text("Diastólica").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                GraficoPressaoComponent(registrosPressoes: vm.pressoes, tipoDePressao: $opcaoSelecionada)
                    .padding([.horizontal, .bottom])
                
                if (vm.pressoes.isEmpty) {
                    BotaoAcaoComponent(texto: "Mais Detalhes", action: nil, desabilitado: true)
                } else {
                    NavigationLink(destination: HistoricoPressaoView(vm: vm)) {
                        BotaoAcaoComponent(texto: "Mais Detalhes", action: nil)
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .scrollIndicators(.hidden)
            .navigationTitle("Pressão")
        }
        .toolbar(content: {
            Button(action: {
                
                showSheet.toggle()
            }, label: {
                Image(systemName: "questionmark.circle")
                    .padding()
                    .font(.title)
                    .foregroundColor(.preto)
            })
        })
        
        .onAppear {
            vm.modelContextPressao = modelContextPressao
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
            sheetInformacoesDasPressoes(showSheet: $showSheet)
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
    
    struct sheetInformacoesDasPressoes: View {
        
        @Binding var showSheet: Bool
        
        var body: some View {
            
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
            
        }
    }
}

#Preview {
    PressaoView(vm: PressaoViewModel())
}
