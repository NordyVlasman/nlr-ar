//
//  Aircraft+CoreDataProperties.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/8/20.
//
//

import Foundation
import CoreData


extension Aircraft {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aircraft> {
        return NSFetchRequest<Aircraft>(entityName: "Aircraft")
    }

    @NSManaged public var name: String?
    @NSManaged public var session: Set<Session>?
    
    public var sessionArray: [Session] {
        let set = session ?? []
        return set.sorted(by: { $0.createdAt!.compare($1.createdAt!) == .orderedDescending})
    }
}

// MARK: Generated accessors for session
extension Aircraft {

    @objc(addSessionObject:)
    @NSManaged public func addToSession(_ value: Session)

    @objc(removeSessionObject:)
    @NSManaged public func removeFromSession(_ value: Session)

    @objc(addSession:)
    @NSManaged public func addToSession(_ values: NSSet)

    @objc(removeSession:)
    @NSManaged public func removeFromSession(_ values: NSSet)

}

extension Aircraft : Identifiable {

}
