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
                    
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                        
                        Text("Nenhum\nremédio\ncadastrado.")
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .foregroundColor(.cinzaClaro)
                    }
                }
                else {
                    List {
                        ForEach(vm.entidadeSalvasRemedio) { entidade in
                            NavigationLink {
                                
                                EditarRemedioView(entidade: entidade, vm: vm)
                                
                            } label: {
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
                                    
                                        .padding()
                                    
                                    HStack {
                                        Image(systemName: "drop.fill")
                                        Text("Dosagem: **\(entidade.dosagem ?? "SEM DOSAGEM")**")
                                            .font(.callout)
                                    }
                                    HStack {
                                        Image(systemName: "timer")
                                        Text("Horário: **\(entidade.horario ?? "SEM HORARIO")**")
                                    }
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
                NavigationLink(destination: AdicionarRemedioView(vm: vm)) {
                    Image(systemName: "plus")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.maisUmVinho)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    RemediosListView()
}
