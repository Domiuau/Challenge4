//
//  AdicionarRemedio.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 30/01/25.
//

import SwiftUI

struct AdicionarRemedio: View {
    
    @StateObject var vm = RemedioViewModel()
    
    @State var nomeRemedio: String = ""
    @State var dosagem: String = ""
    @State var horario: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Nome do Remédio", text: $nomeRemedio)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            TextField("Dosagem", text: $dosagem)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            TextField("Horário a ser tomado", text: $horario)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            Button(action: {
                
                guard !nomeRemedio.isEmpty else { return }
                guard !dosagem.isEmpty else { return }
                guard !horario.isEmpty else { return }
                
                vm.addRemedio(remedioNome: nomeRemedio, dosagem: dosagem, horario: horario)
                
                nomeRemedio = ""
                dosagem = ""
                horario = ""
                
            }, label: {
                Text("Adicionar Remédio")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
            })
        }
    }
}

#Preview {
    AdicionarRemedio()
}
