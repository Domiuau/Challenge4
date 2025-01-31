import Foundation
import CoreData

class RemedioViewModel: ObservableObject {
    private let conteudo = PersistenceController.persistencia.container.viewContext
    @Published var entidadeSalvasRemedio: [RemedioEntity] = []
    
    
    func fetchRemedios() {
        let request = NSFetchRequest<RemedioEntity>(entityName: "RemedioEntity")
        
        do {
            entidadeSalvasRemedio = try conteudo.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data) {
        let newRemedio = RemedioEntity(context: conteudo)
        
        newRemedio.nomeRemedio = remedioNome
        newRemedio.dosagem = dosagem
        newRemedio.horario = horario
        newRemedio.imagem = imagem
        
        print("remedio adicionado")
        
        saveRemedios()
    }
    
    func updateRemedio(remedioNome: String, dosagem: String, horario: String, entidade: RemedioEntity) {
        entidade.nomeRemedio = remedioNome
        entidade.dosagem = dosagem
        entidade.horario = horario
        saveRemedios()
    }
    
    func saveRemedios() {
        do {
            try conteudo.save()
            print("salvo")
            fetchRemedios()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func deleteRemedios(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
            let entity = entidadeSalvasRemedio[index]
        conteudo.delete(entity)
        saveRemedios()
    }
}
