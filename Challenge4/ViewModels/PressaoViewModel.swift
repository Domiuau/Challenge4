/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import Foundation
import CoreData
import SwiftUI
import SwiftData

class PressaoViewModel: ObservableObject {
    private let conteudo = PersistenceController.persistencia.container.viewContext
    static let MAX_SISTOLICO = 190
    static let MIN_SISTOLICO = 30
    static let MAX_DIASTOLICO = 110
    static let MIN_DIASTOLICO = 10
    @Published var pressoes: [PressaoModel] = []
    var modelContext: ModelContext? = nil

    @Published var ordenacaoAscendente: Bool = false {
        didSet {
            fetchPressoes()
        }
    }
    
    func deletePressao(index: IndexSet) {
        
        
        
        guard let index = index.first else { return }
        print("aadasa")
        let pressaoModel = pressoes[index]
        modelContext?.delete(pressaoModel)
        saveData()
        print("deletou a pressao")
//        let entidade = entidadeSalvasPressao[index]
//        conteudo.delete(entidade)

        
    }
    
    func fetchPressoes() {
        let fetchDescriptor = FetchDescriptor<PressaoModel> ()
        pressoes = (try! (modelContext?.fetch(fetchDescriptor))) ?? []
    }
    
    func addPressao(diastolica: Int, sistolica: Int, data: Date) {
        
        let newPressao = PressaoModel(data: data, diastolica: diastolica, sistolica: sistolica)

        modelContext?.insert(newPressao)
        saveData()
        
        print("dados salvos")
    }
    
    func saveData() {
        
        do {
            
            try modelContext?.save()
            fetchPressoes()
            
        } catch let error {
            
            print(error)
        }
        
    }
    
    func situacaoPressao(sistolica: Int) -> String {
        switch (sistolica) {
        case (..<99):
            return "Pressão baixa"
        case (...129):
            return "Pressão normal"
        case (130...190):
            return "Pressão elevada"
        default:
            return "Valores fora do intervalo esperado"
        }
    }
    
    func corSituacaoPressao(situacao: String) -> Color {
        switch (situacao) {
        case "Pressão baixa": return Color.blue
        case "Pressão normal": return Color.preto
        case "Pressão elevada": return Color.maisUmVinho
        default: return Color.gray
        }
    }
    
    static func formatarData(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        return formatter.string(from: date)
    }
    
    static func dataFormatada(data: Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy "
        return dateFormatter.string(from: data!)
    }
    
    static func dataFormatadaHorario(data: Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss "
        return dateFormatter.string(from: data!)
        
    }
    
}
