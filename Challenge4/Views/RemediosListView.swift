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
                            NavigationLink {
                                
                                EditarRemedioView(entidade: entidade, vm: vm)
                                
                            } label: {
                                if let data = entidade.imagem {
                                    Image(uiImage: UIImage(data: data)!.resized(to:200)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                } else {
                                    Image(uiImage: UIImage(named: "remedios")!.resized(to:200)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                }
                                
                                VStack (alignment: .leading) {
                                    Text("**\(entidade.nomeRemedio ?? "SEM NOME")**")
                                        .padding(.vertical)
                                    Text("Dosagem: **\(entidade.dosagem ?? "SEM DOSAGEM")**")
                                    Text("Horário: **\(entidade.horario ?? "SEM HORARIO")**")                                }
                            }
                        }
                        .onDelete(perform: vm.deleteRemedios)
                    }
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
