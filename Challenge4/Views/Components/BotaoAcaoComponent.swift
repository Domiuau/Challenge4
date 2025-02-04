/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI

struct BotaoAcaoComponent: View {
    let texto: String
    var action: (() -> Void)?

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
                .frame(maxWidth: .infinity)
                .padding()
                .frame(width: 300, height: 40)
                .background(Color.outroVinho)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
    }
}

