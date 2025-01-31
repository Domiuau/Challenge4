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

        NavigationView {
                if vm.entidadeSalvasRemedio.isEmpty {
                    Text("Nenhum\nremédio\ncadastrado.")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .foregroundColor(.cinzaClaro)
                }
                else {
                    List {
                        ForEach(vm.entidadeSalvasRemedio) { entidade in
                            HStack {
                                if let data = entidade.imagem {
                                    Image(uiImage: UIImage(data: data)!.resized(to:200)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(.rect(cornerRadius: 10))
                                } else {
                                    Image(uiImage: UIImage(named: "remedios")!.resized(to:200)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(.rect(cornerRadius: 10))
                                }
                                
                                VStack (alignment: .leading) {
                                    Text("**\(entidade.nomeRemedio ?? "SEM NOME")**")
                                        .font(.system(size: 22))
                                    HStack {
                                        Image(systemName: "square.and.arrow.up.badge.clocktimer")
                                        
                                        Text("Dosagem: **\(entidade.dosagem ?? "SEM DOSAGEM")**")
                                            .font(.callout)
                                    }

                                    Text("Horário: **\(entidade.horario ?? "SEM HORARIO")**")
                                }
                            }
                        }
                        .onDelete(perform: vm.deleteRemedios)
                    }
                    .listStyle(InsetListStyle())
                    .scrollContentBackground(.hidden)
                }
        }
        .onAppear {
            vm.fetchRemedios()
        }
        .navigationTitle("Remédios")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink(destination: AdicionarRemedio(vm: vm)) {
                    Image("Group 1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    RemediosListView()
}
