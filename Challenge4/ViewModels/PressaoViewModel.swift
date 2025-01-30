//
//  PressaoCoreDataViewModel.swift
//  Challenge4
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 30/01/25.
//

import Foundation
import CoreData

class PressaoViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var entidadeSalvas: [PressaoEntity] = []
    
    init() {
        
        self.container = NSPersistentContainer(name: "CoreDataContainer")
        self.container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            } else {
                print("foi")
            }
        }
        fetchPressoes()
    }
    
    func deletePressao(index: IndexSet) {
        guard let index = index.first else { return }
        let entidade = entidadeSalvas[index]
        container.viewContext.delete(entidade)
        saveData()
        
    }
    
    
    func fetchPressoes() {
        let request = NSFetchRequest<PressaoEntity>(entityName: "PressaoEntity")
        
        do {
           entidadeSalvas = try container.viewContext.fetch(request)
            
        } catch let error {
            print(error)
        }
        
    }
    
    func addPressao(diastolica: Int, sistolica: Int) {
        
        let newPressao = PressaoEntity(context: container.viewContext)
        newPressao.diastolica = Int16(diastolica)
        newPressao.sistolica = Int16(diastolica)
        newPressao.data = Date()
        saveData()
    }
    
    func saveData() {
        
        do {
            
            try container.viewContext.save()
           fetchPressoes()
            
        } catch let error {
            
            print(error)
        }
        
    }
    
}
