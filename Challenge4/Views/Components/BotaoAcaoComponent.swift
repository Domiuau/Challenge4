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
    var desabilitado: Bool = false
    
    var body: some View {
        if let action = action {
            Button(action: action, label: {
                
                RoundedRectangle(cornerRadius: 50).overlay(
                    Text(texto)
                        .foregroundColor(.white)
                    
                )
                .padding(.horizontal)
                .frame(height: 42)
                .foregroundColor(desabilitado ? Color.cinzaClaro : Color.outroVinho)
            })
            .disabled(desabilitado)
            
            
        } else {
            RoundedRectangle(cornerRadius: 50).overlay(
                Text(texto)
                    .foregroundColor(.white)
                
            )
            .padding(.horizontal)
            .frame(height: 42)
            .foregroundColor(desabilitado ? Color.cinzaClaro : Color.outroVinho)
        }
    }
}

