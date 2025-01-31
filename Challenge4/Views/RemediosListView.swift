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
                    List {
                        ForEach(vm.entidadeSalvasRemedio) { entidade in
                            HStack {
                                if let data = entidade.imagem {
                                    Image(uiImage: UIImage(data: data)!.resized(to:200)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } else {
                                    Image(uiImage: UIImage(named: "remedios")!.resized(to:200)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                
                                VStack (alignment: .leading) {
                                    Text("**\(entidade.nomeRemedio ?? "SEM NOME")**")
                                        .padding(.vertical)
                                    Text("Dosagem: **\(entidade.dosagem ?? "SEM HORARIO")**")
                                    Text("Horário: **\(entidade.horario ?? "SEM DOSAGEM")**")
                                    
                                }
                                .padding(10)
                            }
                        }
                        .padding(10)
                    }
                }
            }
        }
        .navigationTitle("Remédios")
        .toolbar {
            ToolbarItem {
                NavigationLink("Adicionar Remédio", destination: AdicionarRemedio(vm: vm))
            }
        }
    }
}

#Preview {
    RemediosListView()
}
