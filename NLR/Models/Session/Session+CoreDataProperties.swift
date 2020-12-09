//
//  Session+CoreDataProperties.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/8/20.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var createdBy: String?
    @NSManaged public var status: Int32
    @NSManaged public var aircraft: Aircraft?
    @NSManaged public var notes: Set<Notes>?
    @NSManaged public var damageNodes: Set<DamageNode>?
    
    public var damageNodeArray: [DamageNode] {
        let set = damageNodes ?? []
        return set.sorted(by: {
            $0.createdAt!.compare($1.createdAt!) == .orderedDescending
        })
    }
    
    public var notesArray: [Notes] {
        let set = notes ?? []
        return set.sorted(by: {
            $0.createdAt!.compare($1.createdAt!) == .orderedDescending
        })
    }

}

// MARK: Generated accessors for notes
extension Session {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Notes)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Notes)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

// MARK: Generated accessors for damageNodes
extension Session {

    @objc(addDamageNodesObject:)
    @NSManaged public func addToDamageNodes(_ value: DamageNode)

    @objc(removeDamageNodesObject:)
    @NSManaged public func removeFromDamageNodes(_ value: DamageNode)

    @objc(addDamageNodes:)
    @NSManaged public func addToDamageNodes(_ values: NSSet)

    @objc(removeDamageNodes:)
    @NSManaged public func removeFromDamageNodes(_ values: NSSet)

}

extension Session : Identifiable {

}
