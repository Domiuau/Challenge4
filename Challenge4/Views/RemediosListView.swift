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
                        .font(.system(size: 70))
                        .foregroundColor(.cinzaClaro)
                    
                    Spacer().frame(height: 10)
                    
                    Text("""
                    Nenhum remédio cadastrado
                    """)
                    
                    .multilineTextAlignment(.center)
                    .font(.title2)
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
                                    .frame(width: 120, height: 120)
                                    .clipShape(.rect(cornerRadius: 10))
                            } else {
                                Image(uiImage: UIImage(named: "remedios")!.resized(to:200)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                            
                            VStack (alignment: .leading) {
                                HStack {
                                    Text("**\(entidade.nomeRemedio ?? "SEM NOME")**")
                                        .font(.system(size: 22))
                                        .padding(.bottom, 10)
                                    
                                    Spacer()
                                    
                                }
                                HStack {
                                    Image(systemName: "pills.fill")
                                    Text("Dosagem: **\(entidade.dosagem ?? "SEM DOSAGEM")**")
                                        .font(.callout)
                                }
                                
                                HStack {
                                    Image(systemName: "timer")
                                    Text("Horário: **\(entidade.horario ?? "SEM HORARIO")**")
                                        .font(.callout)
                                }
                                HStack{
                                    Image(systemName: entidade.notifyOn ? "bell.fill" : "bell.slash.fill")
                                    Text("Notificação: **\(entidade.notifyOn ? "Ativado" : "Desativado")**")
                                }
                            }
                                
                            .padding(.leading, 20)
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
