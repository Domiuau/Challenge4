//
//  Persistence.swift
//  Challenge4
//
//  Created by JOAO VICTOR FARIAS TEIXEIRA on 31/01/25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let persistencia = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataContainer")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL (fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unsolved error \(error), \(error.userInfo)")
            }
        })
    }
}
