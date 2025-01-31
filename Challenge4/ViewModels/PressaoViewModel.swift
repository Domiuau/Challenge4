import Foundation
import CoreData

class PressaoViewModel: ObservableObject {
    private let conteudo = PersistenceController.persistencia.container.viewContext
    @Published var entidadeSalvasPressao: [PressaoEntity] = []
    @Published var maiorSistolica: Int = Int.min
    @Published var menorSistolica: Int = Int.max
    
    func deletePressao(index: IndexSet) {
        guard let index = index.first else { return }
        let entidade = entidadeSalvasPressao[index]
        conteudo.delete(entidade)
        saveData()
        
    }
    
    
    func fetchPressoes() {
        let request = NSFetchRequest<PressaoEntity>(entityName: "PressaoEntity")
        maiorSistolica = Int.min
        menorSistolica = Int.max
        
        do {
            entidadeSalvasPressao = try conteudo.fetch(request)
            
            for pressao in entidadeSalvasPressao {
                
                if pressao.sistolica > maiorSistolica {
                    maiorSistolica = Int(pressao.sistolica)
                }
                
                if pressao.sistolica < menorSistolica {
                    menorSistolica = Int(pressao.sistolica)
                }
            }
            
        } catch let error {
            print(error)
        }
        
    }
    
    func addPressao(diastolica: Int, sistolica: Int) {
        print("dados salvos")
        
        let newPressao = PressaoEntity(context: conteudo)
        newPressao.diastolica = Int16(diastolica)
        newPressao.sistolica = Int16(sistolica)
        newPressao.data = Date()
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
    
    func situacaoPressao() -> String {
        return ""
    }
    
    func formatarData(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        return formatter.string(from: date)
    }
    
}
