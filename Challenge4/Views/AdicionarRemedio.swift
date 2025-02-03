//
//  AdicionarRemedio.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 30/01/25.
//

import SwiftUI
import PhotosUI


struct AdicionarRemedio: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm: RemedioViewModel
    
    @State private var imagem: UIImage?
    @State var photoPicker: PhotosPickerItem?
    @State var nomeRemedio: String = ""
    @State var dosagem: String = ""
    @State var horario = Date()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack{
                    PhotosPicker(selection: $photoPicker, matching: .images) {
                        Image(uiImage: imagem ?? UIImage(named: "remedios")!.resized(to:200)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 10))
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
                    } // VStack
                    .padding()
                } // HStack
                .padding()
                
                Text("Dosagem (miligramas)")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                TextField("Dosagem", text: $dosagem)
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
                
                DatePicker("", selection: $horario, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                
                
                BotaoAcaoComponent(texto: "Cadastrar", action: {
                    
                    guard !nomeRemedio.isEmpty else { return }
                    guard !dosagem.isEmpty else { return }
                    guard var imagem = imagem else { return }
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    
                    guard let imageData = imagem.pngData() else {
                        print("Erro ao converter imagem para Data")
                        return
                    }
                    
                    vm.addRemedio(remedioNome: nomeRemedio, dosagem: dosagem, horario: dateFormatter.string(from: horario), imagem: imageData)
                    
                    nomeRemedio = ""
                    dosagem = ""
                    dismiss()
                }) // BotaoAcaoComponente
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Cadastro de Remédios")
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
