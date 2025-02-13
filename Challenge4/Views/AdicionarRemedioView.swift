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

struct AdicionarRemedioView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm: RemedioViewModel
    
    @State private var imagem: UIImage?
    @State var photoPicker: PhotosPickerItem?
    @State var nomeRemedio: String = ""
    @State var valorDosagem: String = ""
    @State var horario = Date()
    @State private var tipoDosagemSelected = "Comprimido(s)"
    let tiposDosagem = ["Comprimido(s)", "Capsula(s)", "Gotas", "Miligramas", "Mililitros"]
    
    @State private var feedback1 = true
    @State private var feedback2 = true
    @State private var showAlert = false
    @State private var notifyOn = false
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                VStack (alignment: .leading) {
                    HStack{
                        PhotosPicker(selection: $photoPicker, matching: .images) {
                            if let imagemSelecionada = imagem {
                                
                                Image(uiImage: imagem ?? UIImage(named: "remedios")!.resized(to:200)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(.rect(cornerRadius: 10))
                                
                            } else {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 100, height: 100)
                                        .clipShape(.rect(cornerRadius: 10))
                                        .foregroundColor(.cinzaMaisClaro)
                                    
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .font(.system(size: 35))
                                        .foregroundColor(Color.preto)
                                        .opacity(0.5)
                                    
                                    
                                }
                                .frame(width: 100, height: 100)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Nome")
                                .font(.title2)
                                .bold()
                            
                            TextField("Nome do Remédio", text: $nomeRemedio)
                                .font( .title3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(height: 2)
                                        .opacity(0.44)
                                        .foregroundColor(.gray), alignment: .bottom
                                )
                                .onChange(of: nomeRemedio) { oldValue, newValue in
                                    if !newValue.isEmpty {
                                        feedback1 = false
                                    } else {
                                        feedback1 = true
                                    }
                                }
                            if feedback1 {
                                Text("Este campo é obrigatório")
                                    .foregroundStyle(Color.vinhoBotoes)
                                    .font(.caption)
                            }
                        }
                        .padding()
                    }
                    .padding()
                    
                    Text("Dosagem")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("Ex: 2", text: $valorDosagem)
                                .keyboardType(.numberPad)
                                .font(.title3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(height: 2)
                                        .opacity(0.44)
                                        .foregroundColor(.gray), alignment: .bottom
                                )
                                .font(.title)
                                .onChange(of: valorDosagem) { oldValue, newValue in
                                    if !newValue.isEmpty {
                                        feedback2 = false
                                    } else {
                                        feedback2 = true
                                    }
                                }
                                .frame(width: 70)
                            
                            Picker ("Tipo", selection: $tipoDosagemSelected){
                                ForEach(tiposDosagem, id: \.self) { tipo in
                                    Text(tipo).tag(tipo)
                                        .fontWeight(.heavy)
                                }
                            }
                            .accentColor(.primary)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.cinzaMaisClaro)
                            )
                            .pickerStyle(DefaultPickerStyle())
                        }
                        
                        if feedback2 {
                            Text("Este campo é obrigatório")
                                .foregroundStyle(Color.vinhoBotoes)
                                .font(.caption)
                        }
                    }
                    .padding()
                    
                    
                    Text("Horários")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                }
                
                DatePicker("", selection: $horario, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .aspectRatio(contentMode: .fit)
                    .labelsHidden()
                
                Toggle ("Ativar notificação", isOn: $notifyOn)
                    .padding()
                
                BotaoAcaoComponent(texto: "Cadastrar", action: {
                    
                    guard !nomeRemedio.isEmpty else { return }
                    guard !valorDosagem.isEmpty else { return }
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let imageDataConfirmada: Data?
                    
                    if let imagem = imagem {
                        guard let imageData = imagem.pngData() else {
                            print("Erro ao converter imagem para Data")
                            return
                        }
                        
                        imageDataConfirmada = imageData
                        
                    } else {
                        imageDataConfirmada = nil
                    }
                    
                    
                    
                    vm.addRemedio(remedioNome: nomeRemedio, dosagem: valorDosagem + " " + tipoDosagemSelected, horario: dateFormatter.string(from: horario), imagem: imageDataConfirmada, notifyOn: notifyOn)
                    
                    showAlert.toggle()
                }, desabilitado: ((nomeRemedio.isEmpty) || (valorDosagem.isEmpty)))
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Remédio cadastrado!"),
                        message: Text("O remédio \(nomeRemedio) foi cadastrado com sucesso"),
                        dismissButton: .default(Text("OK"),
                                                action: {
                                                    nomeRemedio = ""
                                                    valorDosagem = ""
                                                    dismiss()
                                                })
                    )
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            
        }
        .scrollDismissesKeyboard(.immediately)
        .navigationTitle("Cadastrar Remédio")
        .onChange(of: photoPicker, { _, _ in
            Task {
                if let photoPicker, let data = try? await photoPicker.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        imagem = image
                    }
                }
                
                photoPicker = nil
                
            }
        })
    }
}

extension UIImage {
    func resized(to maxWidth: CGFloat) -> UIImage? {
        let aspectRatio = self.size.height / self.size.width
        let height = maxWidth * aspectRatio
        let size = CGSize(width: maxWidth, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
