//
//  Coordinates+CoreDataProperties.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/8/20.
//
//

import Foundation
import CoreData


extension Coordinates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coordinates> {
        return NSFetchRequest<Coordinates>(entityName: "Coordinates")
    }

    @NSManaged public var x: Float
    @NSManaged public var y: Float
    @NSManaged public var z: Float
    @NSManaged public var node: DamageNode?

}

extension Coordinates : Identifiable {

}
