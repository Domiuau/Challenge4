//
//  RemedioCoreDataViewModel.swift
//  Challenge4
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 30/01/25.
//

import Foundation
import CoreData

class RemedioViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var savedEntities: [RemedioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
        
        fetchRemedios()
        
    }
    
    func fetchRemedios() {
        let request = NSFetchRequest<RemedioEntity>(entityName: "RemedioEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addRemedio(remedioNome: String, dosagem: String, horario: String) {
        let newRemedio = RemedioEntity(context: container.viewContext)
        
        newRemedio.nomeRemedio = remedioNome
        newRemedio.dosagem = dosagem
        newRemedio.horario = horario
        
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
            try container.viewContext.save()
            print("salvo")
            fetchRemedios()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func deleteRemedios(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
            let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveRemedios()
    }
}
