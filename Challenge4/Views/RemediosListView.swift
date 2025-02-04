/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI

struct RemediosListView: View {
    
    @StateObject var vm = RemedioViewModel()
    
    var body: some View {
        
        NavigationStack {
            if vm.entidadeSalvasRemedio.isEmpty {
                
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.cinzaClaro)
                    
                    Text("Você ainda não adicionou\num remédio")
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
                                    .padding(.bottom, 5)
                                
                                HStack {
                                    Image(systemName: "drop.fill")
                                    Text("Dosagem: **\(entidade.dosagem ?? "SEM DOSAGEM")**")
                                        .font(.callout)
                                }
                                
                                HStack {
                                    Image(systemName: "timer")
                                    Text("Horário: **\(entidade.horario ?? "SEM HORARIO")**")
                                        .font(.callout)
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
