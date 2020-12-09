//
//  DamageNode+CoreDataProperties.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/8/20.
//
//

import Foundation
import CoreData


extension DamageNode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DamageNode> {
        return NSFetchRequest<DamageNode>(entityName: "DamageNode")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var recordingURL: URL?
    @NSManaged public var damageState: Int32
    @NSManaged public var fixNow: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var node: String?
    @NSManaged public var title: String?
    @NSManaged public var createdBy: String?
    @NSManaged public var coordinates: Coordinates?
    @NSManaged public var notes: NSSet?
    @NSManaged public var session: Session?
    
    
    var damageStatus: DamageState {
        get {
            return DamageState(rawValue: self.damageState)!
        }
        set {
            self.damageState = newValue.rawValue
        }
    }

}

// MARK: Generated accessors for notes
extension DamageNode {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Notes)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Notes)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension DamageNode : Identifiable {

}
