//
//  Notes+CoreDataProperties.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/8/20.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var createdBy: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var text: String?
    @NSManaged public var damageNode: DamageNode?
    @NSManaged public var session: Session?

}

extension Notes : Identifiable {

}
