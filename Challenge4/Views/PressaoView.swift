//
//  ContentView.swift
//  Challenge4
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/01/25.
//

import SwiftUI

struct PressaoView: View {
    @State private var sistolico: Int? = nil
    @State private var diastolico: Int? = nil
    @State private var inputTextS: String = ""
    @State private var inputTextD: String = ""
    
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
                            sistolico = Int(newValue)
                        }
                    
                    Spacer().frame(height: 10)
                    
                    TextField("Diastólico", text: $inputTextD)
                        .keyboardType(.numberPad)
                        .font(.system(size: 50))
                        .onChange(of: inputTextD) { newValue in
                            sistolico = Int(newValue)
                        }
                }
                .padding()
                
                Button("Salvar") {
                    
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
