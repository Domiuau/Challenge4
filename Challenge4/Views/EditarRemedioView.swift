/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI
import PhotosUI

struct EditarRemedioView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let entidade: RemedioEntity
    @ObservedObject var vm: RemedioViewModel
    
    @State var novoNome = ""
    @State var novaDosagem = ""
    @State var novoHorario = Date()
    @State private var novaImagem: UIImage?
    @State private var entidadeImagem: UIImage?
    @State var photoPicker: PhotosPickerItem?
    
    init(entidade: RemedioEntity, vm: RemedioViewModel) {
        self.entidade = entidade
        self.vm = vm
        
        if let imagemData = entidade.imagem, let imagem = UIImage(data: imagemData) {
            _entidadeImagem = State(initialValue: imagem)
        } else {
            _entidadeImagem = State(initialValue: UIImage(named: "remedios"))
        }
        
        _novoNome = State(initialValue: entidade.nomeRemedio ?? "")
        _novaDosagem = State(initialValue: entidade.dosagem ?? "")
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 20){
                HStack{
                    PhotosPicker(selection: $photoPicker, matching: .images) {
                        if let novaImagem = novaImagem {
                            
                            Image(uiImage: novaImagem.resized(to: 300)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(.rect(cornerRadius: 10))
                            
                        } else if let entidadeImagem = entidade.imagem, let imagemAntiga = UIImage(data: entidadeImagem) {
                            ZStack {
                                Image(uiImage: imagemAntiga.resized(to: 300)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(.rect(cornerRadius: 10))
                                
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.black)
                                    .opacity(0.4)
                                    .clipShape(.rect(cornerRadius: 10))
                                
                                Image(systemName: "applepencil.gen2")
                                    .bold()
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                        } else {
                            
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(.rect(cornerRadius: 10))
                            
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Nome")
                            .font(.title2)
                            .bold()
                        
                        TextField(entidade.nomeRemedio ?? "Nome do Remédio", text: $novoNome)
                            .font( .title3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(height: 2)
                                    .opacity(0.44)
                                    .foregroundColor(.gray), alignment: .bottom
                            )
                    }
                    .padding()
                }
                .padding()
                
                
                Text("Dosagem (miligramas)")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                TextField(entidade.dosagem ?? "Remédio sem dosagem", text: $novaDosagem)
                    .font(.title3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .frame(height: 2)
                            .opacity(0.44)
                            .foregroundColor(.gray), alignment: .bottom
                    )
                    .padding()
                    .font(.title)
                
                Text("Horários")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                DatePicker("", selection: $novoHorario, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                
                BotaoAcaoComponent(texto: "Editar", action: {
                    
                    guard !novoNome.isEmpty else { return }
                    guard !novaDosagem.isEmpty else { return }
                    
                    let imagemSalvar = novaImagem ?? entidadeImagem
                    
                    guard let imagem = imagemSalvar else { return }
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    
                    guard let imageData = imagem.pngData() else {
                        print("Erro ao converter imagem para Data")
                        return
                    }
                    
                    vm.updateRemedio(remedioNome: novoNome, dosagem: novaDosagem, horario: dateFormatter.string(from: novoHorario), imagem: imageData, entidade: entidade)
                    
                    novoNome = ""
                    novaDosagem = ""
                    dismiss()
                    
                })
                .frame(maxWidth: .infinity)
            }
            .padding()
            .navigationTitle("Editor de Remédios")
            .onChange(of: photoPicker, { _, _ in
                Task {
                    if let photoPicker, let data = try? await photoPicker.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            novaImagem = image
                        }
                    }
                    
                    photoPicker = nil
                    
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Remédios") {
                        dismiss()
                    }
                    .padding(.leading, -18)
                    .background(Color.red)
                }
            }
        }
    }
}
