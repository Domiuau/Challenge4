/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import Foundation
import SwiftData
import SwiftUI

class PressaoViewModel: ObservableObject {
    private let conteudo = PersistenceController.persistencia.container.viewContext
    static let MAX_SISTOLICO = 190
    static let MIN_SISTOLICO = 30
    static let MAX_DIASTOLICO = 110
    static let MIN_DIASTOLICO = 10
    @Query var entidadeSalvasPressao: [PressaoModel]
    @Published var ordenacaoAscendente: Bool = false
    
    func deletePressao(index: IndexSet) {
        guard let index = index.first else { return }
        let entidade = entidadeSalvasPressao[index]
       // modelContext.delete(entidade)
        saveData()
        
    }
    
    func addPressao(diastolica: Int, sistolica: Int, data: Date, context: ModelContext) {
        print("dados salvos")
        

        
        let newPressao = PressaoModel(data: data, diastolica: diastolica, sistolica: sistolica)
        context.insert(newPressao)
        saveData()
        

        
        print("dados salvos")
    }
    
    func saveData() {
        
        do {
                //try modelContext.save() // Salvando no contexto
            } catch {
                print("Erro ao salvar: \(error.localizedDescription)")
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
    
    func formatarData(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        return formatter.string(from: date)
    }
    
    func dataFormatada(data: Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy "
        return dateFormatter.string(from: data!)
    }
    
    func dataFormatadaHorario(data: Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss "
        return dateFormatter.string(from: data!)
        
    }
    
}
