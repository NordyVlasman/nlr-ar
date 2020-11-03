//
//  PersistenceController.swift
//  NLR
//
//  Created by Nordy Vlasman on 03/11/2020.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    private let aircraftsList = ["F-35 - F001", "F-35 - F002", "F-35 - F003", "F-35 - F004"]
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for i in 0..<10 {
            let aircraft = Aircraft(context: viewContext)
            aircraft.name = "F-35 - \(i)"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(error), \(nsError.userInfo)")
        }
        
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NLR")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func fetchAircrafts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Aircraft")
        
        do {
            let aircrafts = try container.viewContext.fetch(fetchRequest) as! [Aircraft]
            if aircrafts.isEmpty {
                for aircraftName in aircraftsList {
                    let aircraft = Aircraft(context: container.viewContext)
                    aircraft.name = aircraftName
                    
                    saveContext()
                }
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(error), \(nsError.userInfo)")
        }
    }
    
    // MARK: - Saving Core Data
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(error), \(nsError.userInfo)")
            }
        }
    }
}
