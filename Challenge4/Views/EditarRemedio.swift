//
//  EditarRemedio.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 31/01/25.
//

import SwiftUI
import PhotosUI

struct EditarRemedioView: View {
    
    let entidade: RemedioEntity
    @ObservedObject var vm: RemedioViewModel
    
    
    @State var novoNome = ""
    @State var novaDosagem = ""
    @State var novoHorario = Date()
    @State private var novaImagem: UIImage?
    @State var photoPicker: PhotosPickerItem?
    
    var body: some View {
        VStack {
            TextField(entidade.nomeRemedio ?? "Remédio Sem Nome", text: $novoNome)
            TextField(entidade.dosagem ?? "Remédio sem dosagem", text: $novaDosagem)
            
            PhotosPicker(selection: $photoPicker, matching: .images) {
                if let novaImagem = novaImagem {
                    
                    Image(uiImage: novaImagem.resized(to: 50)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                } else if let entidadeImagem = entidade.imagem, let imagemAntiga = UIImage(data: entidadeImagem) {
                    
                    Image(uiImage: imagemAntiga.resized(to: 50)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                } else {
                    
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                }
            }
        }
        .onChange(of: photoPicker, { _, _ in
            Task {
                if let photoPicker, let data = try? await photoPicker.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        UIImage(data: entidade.imagem) = image
                    }
                }
                
                photoPicker = nil
                
            }
        })
    }
}
