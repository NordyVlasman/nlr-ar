//
//  AircraftManager.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/17/20.
//

import Combine
import Foundation
import CoreData

class AircraftManager: ObservableObject {
    public static let shared = AircraftManager()
    
    let context = PersistenceController.shared.container.viewContext
    
    @Published var currentAircraft: Aircraft?
    
    func setCurrentSelectedAirplane(airplane: String) -> Aircraft?{
        let request = NSFetchRequest<Aircraft>(entityName: "Aircraft")
        request.predicate = NSPredicate(format: "name == %@", airplane)
        
        do {
            let airplane = try context.fetch(request)
            print(airplane.count)
            if airplane.count == 1 {
                currentAircraft = airplane.first
                return airplane.first
            } else {
                return nil
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error). \(error.userInfo)")
            return nil
        }
    }
}
