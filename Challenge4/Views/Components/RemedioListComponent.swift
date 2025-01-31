//
//  RemedioListComponent.swift
//  Challenge4
//
//  Created by Amanda Rodrigues on 31/01/25.
//

import SwiftUI

public struct RemedioListComponent: View {
    
    @ObservedObject var vm: RemedioViewModel
    
    public var body: some View {
        
        HStack{
            
            ForEach(vm.savedEntities, id: \.self) { entidade in
                if let data = entidade.imagem {
                    Image(uiImage: UIImage(data: data)!.resized(to:200)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                       // .frame(width: 50, height: 50)
                    
                } else {
                    Image(uiImage: UIImage(named: "remedios")!.resized(to:200)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                       // .frame(width: 50, height: 50)
                    
                }
                
                VStack (alignment: .leading) {
                    Text("**\(entidade.nomeRemedio ?? "SEM NOME")**")
                        .padding(.vertical)
                    Text("Dosagem: **\(entidade.horario ?? "SEM HORARIO")**")
                    Text("Horário: **\(entidade.dosagem ?? "SEM DOSAGEM")**")
                       
                }
                .padding(10)
            }
        }
        .frame(height: 100)
        .padding(10)
        
        HStack{
            
           
        }
        .frame(height: 100)
        .padding(10)
    }
}

#Preview {
    RemedioListComponent(vm: .init())
}
