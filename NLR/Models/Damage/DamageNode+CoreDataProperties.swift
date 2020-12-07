//
//  Damage+CoreDataProperties.swift
//  NLR
//
//  Created by Nordy Vlasman on 04/11/2020.
//

import Foundation
import CoreData

extension DamageNode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DamageNode> {
        return NSFetchRequest<DamageNode>(entityName: "DamageNode")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var node: String?
    @NSManaged public var damageState: Int32
    @NSManaged public var fixNow: Bool
    @NSManaged public var aircraft: NSSet?
    @NSManaged public var coordinates: Coordinates?
    @NSManaged public var currentURL: URL?
    
    var damageStatus: DamageState {
        get {
            return DamageState(rawValue: self.damageState)!
        }
        set {
            self.damageState = newValue.rawValue
        }
    }

}

// MARK: Generated accessors for aircraft
extension DamageNode {

    @objc(addAircraftObject:)
    @NSManaged public func addToAircraft(_ value: Aircraft)

    @objc(removeAircraftObject:)
    @NSManaged public func removeFromAircraft(_ value: Aircraft)

    @objc(addAircraft:)
    @NSManaged public func addToAircraft(_ values: NSSet)

    @objc(removeAircraft:)
    @NSManaged public func removeFromAircraft(_ values: NSSet)

}
