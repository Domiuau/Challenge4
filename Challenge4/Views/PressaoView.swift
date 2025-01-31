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
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
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
                            sistolica = Int(newValue)
                        }
                }
                .padding()
                
                Button("Salvar") {
                    if let sistolica = sistolica, let diastolica = diastolica {
                        vm.addPressao(diastolica: diastolica, sistolica: sistolica)
                        inputTextS = ""
                        inputTextD = ""
                    }
                }
                .padding()
                .frame(width: 300, height: 40)
                .background(.vinhoBotoes)
                .foregroundColor(.white)
                .cornerRadius(50)
            }
            .padding()
        }
        .navigationTitle("Pressão")
    }
}

#Preview {
    PressaoView()
}
