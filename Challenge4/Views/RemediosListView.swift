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
    
    @Environment(\.modelContext) var modelContextRemedio
    @StateObject var vm = RemedioViewModel()
    
    var body: some View {
        
        NavigationStack {
            if vm.remedios.isEmpty {
                
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
                    ForEach(vm.remedios) { entidade in
                        NavigationLink {
                            
                            EditarRemedioView(entidade: entidade, vm: vm)
                            
                        } label: {
                            
                            if let imagem = entidade.imagem {
                                ImagemRemedioView(uiImage: UIImage(data: imagem))

                            } else {
                                Image(systemName: "cross.case.fill")
                                    .resizable()
                                    .padding(8)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100, alignment: .center)

                            }
                             
                            
                            VStack (alignment: .leading) {
                                HStack {
                                    Text("**\(entidade.nomeRemedio)**")
                                        .font(.system(size: 22))
                                        .padding(.bottom, 10)
                                    
                                    Spacer()
                                    
                                }
                                HStack {
                                    Image(systemName: "pills.fill")
                                    Text("Dosagem: **\(entidade.dosagem)**")
                                        .font(.callout)
                                }
                                
                                HStack {
                                    Image(systemName: "timer")
                                    Text("Horário: **\(entidade.horario)**")
                                        .font(.callout)
                                }
                                HStack{
                                    Image(systemName: entidade.notifyOn ? "bell.fill" : "bell.slash.fill")
                                    Text("Notificação: **\(entidade.notifyOn ? "Ativado" : "Desativado")**")
                                        .lineLimit(1)
                                }
                            }
                                
                            .padding(.leading, 20)
                        }
                        
                    }
                    .onDelete(perform: { indexSet in
                        vm.deleteRemedio(index: indexSet)
                        
                    } )
                }
                .listStyle(InsetListStyle())
                .scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            vm.modelContextRemedios = modelContextRemedio
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
    
    struct ImagemRemedioView: View {
        
        let uiImage: UIImage?
        
        var body: some View {
            Image(uiImage: uiImage!.resized(to:200)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
}

#Preview {
    RemediosListView()
}
