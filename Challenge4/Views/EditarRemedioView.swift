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
    
    let entidade: RemediosModel
    @ObservedObject var vm: RemedioViewModel
    
    @State var novoNome: String
    @State var novaDosagem: String
    @State var novoHorario: Date
    @State private var novaImagem: UIImage?
    @State private var entidadeImagem: UIImage?
    @State var photoPicker: PhotosPickerItem?
    @State private var imagemTrocada = false
    @State private var showDeleteConfirmation = false
    private let antigoNome: String
    private let antigaDosagem: String
    private let antigoHorario: String
    private let antigaImagem: Data?
    private let antigoNotifyOn: Bool
    @State private var notifyOn: Bool
    private let dateFormatterHora = DateFormatter()
    
    @State private var showAlert = false
    
    init(entidade: RemediosModel, vm: RemedioViewModel) {
        self.entidade = entidade
        self.vm = vm
        
        if let data = entidade.imagem {
            
            antigaImagem = data
            
            if let imagemData = UIImage(data: data) {
                _entidadeImagem = State(initialValue: imagemData)
            } else {
                _entidadeImagem = State(initialValue: UIImage(named: "remedios"))
            }
        } else {
            antigaImagem = nil
        }
        
        
        
        antigoNome = entidade.nomeRemedio
        antigaDosagem = entidade.dosagem
        antigoHorario = entidade.horario
        _notifyOn = State(initialValue: entidade.notifyOn)
        
        _novoNome = State(initialValue: entidade.nomeRemedio)
        _novaDosagem = State(initialValue: entidade.dosagem)
        
        
        dateFormatterHora.dateFormat = "HH:mm"
        
        _novoHorario = State(initialValue: dateFormatterHora.date(from: entidade.horario) ?? Date())
        antigoNotifyOn = entidade.notifyOn
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20){
                VStack (alignment: .leading) {
                    HStack{
                        PhotosPicker(selection: $photoPicker, matching: .images) {
                            if let novaImagem = novaImagem {
                                
                                Image(uiImage: novaImagem.resized(to: 300)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(.rect(cornerRadius: 10))
                                
                            } else if let entidadeImagem = antigaImagem {
                                ZStack {
                                    Image(uiImage: UIImage(data: entidadeImagem)!)
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
                                
                                ZStack {
                                    Rectangle()
                                        .frame(width: 100, height: 100)
                                        .clipShape(.rect(cornerRadius: 10))
                                        .foregroundColor(.cinzaClaro)
                                    
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .font(.system(size: 35))
                                        .foregroundColor(Color.preto)
                                        .opacity(0.5)
                                    
                                    
                                }
                                .frame(width: 100, height: 100)
                                
                            }
                        }
                        .onChange(of: photoPicker) { newSelection in
                            
                            imagemTrocada = true
                            
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Nome")
                                .font(.title2)
                                .bold()
                            
                            TextField(entidade.nomeRemedio, text: $novoNome)
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
                    
                    
                    Text("Dosagem")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    
                    TextField(entidade.dosagem, text: $novaDosagem)
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
                }
                
                DatePicker("gdfgdth", selection: $novoHorario, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .aspectRatio(contentMode: .fit)
                    .labelsHidden()
                
                Toggle ("Ativar notificação", isOn: $notifyOn)
                    .padding()
                
                BotaoAcaoComponent(texto: "Salvar", action: {
                    
                    
                    guard !novoNome.isEmpty else { return }
                    guard !novaDosagem.isEmpty else { return }
                    
                    let imagemSalvar = novaImagem ?? entidadeImagem
                    
                    guard let imagem = imagemSalvar else { return }
                    
                    
                    dateFormatterHora.dateFormat = "HH:mm"
                    
                    guard let imageData = imagem.pngData() else {
                        print("Erro ao converter imagem para Data")
                        return
                    }
                    
                    vm.updateRemedio(remedioNome: novoNome, dosagem: novaDosagem, horario: dateFormatterHora.string(from: novoHorario), imagem: imageData, remedio: entidade, notifyOn: notifyOn)
                    
                    showAlert.toggle()
                    
                }, desabilitado: ((antigoNome == novoNome) && (dateFormatterHora.string(from: novoHorario) == antigoHorario) && (antigaDosagem == novaDosagem) && (!imagemTrocada)) && (antigoNotifyOn == notifyOn))
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Remédio editado!"), message: Text("O remédio foi editado com sucesso"), dismissButton: .default(Text("OK"), action: {
                        novoNome = ""
                        novaDosagem = ""
                        dismiss()
                    }))
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .navigationTitle("Editar Remédio")
            .toolbar { ToolbarItem {
                Image(systemName: "trash")
                    .foregroundColor(Color.red)
                    .onTapGesture {
                        showDeleteConfirmation = true
                    }
            }
            }
            .actionSheet(isPresented: $showDeleteConfirmation) {
                ActionSheet(
                    title: Text("Confirmar Exclusão"),
                    message: Text("Tem certeza de que deseja excluir este remédio? Esta ação não pode ser desfeita."),
                    buttons: [
                        .destructive(Text("Excluir")) {
                            vm.deleteRemedios(entidade: entidade)
                            dismiss()
                        },
                        .cancel()
                    ]
                )
            }
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
        }
    }
}
