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
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                } else {
                    Image(uiImage: UIImage(named: "remedios")!.resized(to:200)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                    
                }
                
                Text("\(entidade.nomeRemedio ?? "SEM NOME")")
                Text("\(entidade.horario ?? "SEM HORARIO")")
                Text("\(entidade.dosagem ?? "SEM DOSAGEM")")
            }
        }
    }
}

#Preview {
    RemedioListComponent(vm: .init())
}
