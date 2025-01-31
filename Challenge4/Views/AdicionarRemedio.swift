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
        VStack(alignment: .leading, spacing: 20) {
            HStack{
                PhotosPicker(selection: $photoPicker, matching: .images) {
                    Image(uiImage: imagem ?? UIImage(named: "remedios")!.resized(to:50)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                    
                }
                VStack(alignment: .leading) {
                    Text("Nome do Remédio")
                        .font(.title2)
                    
                    TextField("Nome do Remédio", text: $nomeRemedio)
                        .padding()
                        .background(Color.cinzaClaro)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.trailing)
                }
                .padding(.leading)
            }
            .padding(.horizontal)
            
            
            Text("Dosagem")
                .font(.title2)
                .padding(.leading)
            
            TextField("Dosagem", text: $dosagem)
                .font(.title2)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.cinzaClaro)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            Text("Horários")
                .font(.title2)
                .padding(.leading)
            
            DatePicker("", selection: $horario, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal)
            
            
            BotaoAcaoComponent(texto: "Adicionar Remédio", action: {
                
                guard !nomeRemedio.isEmpty else { return }
                guard !dosagem.isEmpty else { return }
                guard var imagem = imagem else { return }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm"
                
                guard let imageData = imagem.pngData() else {
                    print("Erro ao converter imagem para Data")
                    return
                }
                
                vm.addRemedio(remedioNome: nomeRemedio, dosagem: dosagem, horario: dateFormatter.string(from: horario), imagem: imageData)
                
                nomeRemedio = ""
                dosagem = ""
                dismiss()
            })
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Cadastro de \nRemédios")
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
