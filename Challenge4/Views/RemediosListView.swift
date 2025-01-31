//
//  SwiftUIView.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 30/01/25.
//

import SwiftUI

struct RemediosListView: View {
    
    @StateObject var vm = RemedioViewModel()
    
    var body: some View {
        ScrollView {
            NavigationView {
                VStack{
                    NavigationLink("Adicionar Remédio", destination: AdicionarRemedio(vm: vm))
                    
                    List {
                        HStack {
                            ForEach(vm.entidadeSalvasRemedio) { entidade in
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
                    }
                }
            }
        }
        .navigationTitle("Remédios")
    }
}

#Preview {
    RemediosListView()
}
