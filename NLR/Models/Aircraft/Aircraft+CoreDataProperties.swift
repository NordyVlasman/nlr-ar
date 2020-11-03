//
//  Aircraft+CoreDataProperties.swift
//  NLR
//
//  Created by Nordy Vlasman on 03/11/2020.
//

import Foundation
import CoreData

extension Aircraft {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aircraft> {
        return NSFetchRequest<Aircraft>(entityName: "Aircraft")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var damageNodes: Set<DamageNode>?
    
    public var damageNodeArray: [DamageNode] {
        let set = damageNodes ?? []
        return set.sorted(by: { $0.createdAt!.compare($1.createdAt!) == .orderedDescending})

    }
}

// MARK: Generated accessors for damageNode
extension Aircraft {

    @objc(addDamageNodeObject:)
    @NSManaged public func addToDamageNode(_ value: DamageNode)

    @objc(removeDamageNodeObject:)
    @NSManaged public func removeFromDamageNode(_ value: DamageNode)

    @objc(addDamageNode:)
    @NSManaged public func addToDamageNode(_ values: NSSet)

    @objc(removeDamageNode:)
    @NSManaged public func removeFromDamageNode(_ values: NSSet)

}
