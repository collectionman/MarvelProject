//
//  ComicStore+CoreDataProperties.swift
//  
//
//  Created by Julian Llorensi on 29/04/2019.
//
//

import Foundation
import CoreData


extension ComicStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ComicStore> {
        return NSFetchRequest<ComicStore>(entityName: "ComicStore")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
