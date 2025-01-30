//
//  AdicionarRemedio.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 30/01/25.
//

import SwiftUI
import PhotosUI


struct AdicionarRemedio: View {
    
    @ObservedObject var vm: RemedioViewModel
    
    @State private var imagem: UIImage?
    @State var photoPicker: PhotosPickerItem?
    @State var nomeRemedio: String = ""
    @State var dosagem: String = ""
    @State var horario = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            
            PhotosPicker(selection: $photoPicker, matching: .images) {
                Image(uiImage: imagem ?? UIImage(named: "remedios")!.resized(to:200)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            }
            
            
            TextField("Nome do Remédio", text: $nomeRemedio)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            TextField("Dosagem", text: $dosagem)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            DatePicker("Selecione a Hora", selection: $horario, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
            
            
            Button(action: {
                
                guard !nomeRemedio.isEmpty else { return }
                guard !dosagem.isEmpty else { return }
                guard let image = imagem else { return }
                
                var dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm"
                
                guard let imageData = imagem?.pngData() else {
                    print("Erro ao converter imagem para Data")
                    return
                }
                
                vm.addRemedio(remedioNome: nomeRemedio, dosagem: dosagem, horario: dateFormatter.string(from: horario), imagem: imageData)
                
                nomeRemedio = ""
                dosagem = ""
                
            }, label: {
                Text("Adicionar Remédio")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
            }) 
        }
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
