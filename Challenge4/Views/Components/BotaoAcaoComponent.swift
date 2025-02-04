//
//  BotaoAcaoComponent.swift
//  Challenge4
//
//  Created by JOAO VICTOR FARIAS TEIXEIRA on 31/01/25.
//

import SwiftUI

struct BotaoAcaoComponent: View {
    let texto: String
    var action: (() -> Void)?  // Permitir ação opcional

    var body: some View {
        if let action = action {
            Button(action: action) {
                Text(texto)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(width: 300, height: 40)
            .background(Color.outroVinho)
            .foregroundColor(.white)
            .cornerRadius(50)
        } else {
            Text(texto)
                .padding()
                .frame(width: 300, height: 40)
                .background(Color.outroVinho)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
    }
}



//#Preview {
//    BotaoAcaoComponent(texto: "default")
//}
