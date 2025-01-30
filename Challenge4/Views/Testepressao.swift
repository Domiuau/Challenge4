//
//  Testepressao.swift
//  Challenge4
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 30/01/25.
//

import SwiftUI

struct Testepressao: View {
    
    @StateObject var pressaoViewModel = PressaoViewModel()
    @State var inputText1 = "122"
    @State var inputText2 = "22"
    
    var body: some View {
        Text("Hello, World!")
        
        Button("adicionar") {
            
            pressaoViewModel.addPressao(diastolica: Int(inputText1)!, sistolica: Int(inputText2)!)
            
            
            
        }
        
        List {
            
            ForEach(pressaoViewModel.entidadeSalvas) {
                entidade in
                
                VStack {
                    Text("diastolica " + String(entidade.diastolica))
                    Text("sistolica " + String(entidade.sistolica))
                    Text(dataFormatada(data: entidade.data))
                }
            }
            
        }
    }
    
    func dataFormatada(data: Date?) -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dataFormatter.string(from: data!)
    }
}

#Preview {
    Testepressao()
}
