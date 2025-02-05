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

class PressaoViewModel: ObservableObject {
    private let conteudo = PersistenceController.persistencia.container.viewContext
    static let MAX_SISTOLICO = 190
    static let MIN_SISTOLICO = 30
    static let MAX_DIASTOLICO = 110
    static let MIN_DIASTOLICO = 10
    @Published var entidadeSalvasPressao: [PressaoEntity] = []
    
    func deletePressao(index: IndexSet) {
        guard let index = index.first else { return }
        let entidade = entidadeSalvasPressao[index]
        conteudo.delete(entidade)
        saveData()
        
    }
    
    func fetchPressoes() {
        let request = NSFetchRequest<PressaoEntity>(entityName: "PressaoEntity")
        
        do {
            entidadeSalvasPressao = try conteudo.fetch(request)
            
        } catch let error {
            print(error)
        }
        
    }
    
    func addPressao(diastolica: Int, sistolica: Int, data: Date) {
        print("dados salvos")
        
        let newPressao = PressaoEntity(context: conteudo)
        newPressao.diastolica = Int16(diastolica)
        newPressao.sistolica = Int16(sistolica)
        newPressao.data = data
        saveData()
        
        print("dados salvos")
    }
    
    func saveData() {
        
        do {
            
            try conteudo.save()
            fetchPressoes()
            
        } catch let error {
            
            print(error)
        }
        
    }
    
    func situacaoPressao(sistolica: Int, diastolica: Int) -> String {
        switch (sistolica, diastolica) {
        case (..<99, ..<69):
            return "Baixa"
        case (...129, ...84):
            return "Normal"
        case (130...190, 85...110):
            return "Elevada"
        default:
            return "Valores fora do intervalo esperado"
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
