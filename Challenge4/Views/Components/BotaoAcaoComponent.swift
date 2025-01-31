//
//  BotaoAcaoComponent.swift
//  Challenge4
//
//  Created by JOAO VICTOR FARIAS TEIXEIRA on 31/01/25.
//

import SwiftUI

struct BotaoAcaoComponent: View {
    let texto: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(texto)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(width: 300, height: 40)
        .background(Color.vinhoBotoes)
        .foregroundColor(.white)
        .cornerRadius(50)
    }
}


//#Preview {
//    BotaoAcaoComponent(texto: "default")
//}
