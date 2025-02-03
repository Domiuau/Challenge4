import Foundation
import CoreData

class PressaoViewModel: ObservableObject {
    private let conteudo = PersistenceController.persistencia.container.viewContext
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
            case (..<90, _), (_, ..<60):
                return "Baixa"
            case (90...119, 60...79):
                return "Normal"
            case (120...129, 60...79):
                return "Elevada"
            default:
                return "Valores Inválidos"
            }
    }
    
    func formatarData(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        return formatter.string(from: date)
    }
    
}
