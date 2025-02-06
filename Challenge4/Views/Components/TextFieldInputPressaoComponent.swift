//
//  TextFieldInputPressaoComponent.swift
//  HearTrack
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 06/02/25.
//

import SwiftUI

struct TextFieldInputPressaoComponent: View {
    
    @Binding var inputText: String
    @Binding var numeroInserido: Int?
    let textoPadrao: String
    
    var body: some View {
        TextField(textoPadrao, text: $inputText)
            .keyboardType(.numberPad)
            .font(.system(size: 40))
            .onChange(of: inputText) { newValue in
                numeroInserido = Int(newValue)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 3)
                    .opacity(0.44)
                    .foregroundColor(.gray), alignment: .bottom
            )
    }
}

