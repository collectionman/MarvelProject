//
//  CoreDataManager.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 30/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

class CoreDataManager {
    var context = NSManagedObjectContext()
    
    init() {
        context = getViewContext()
    }
    
    func saveComicStore(name: String, address: String, latitude: Double, longitude: Double) {
        
        let newComicStore = ComicStore(context: context)
        newComicStore.title = name
        newComicStore.subtitle = address
        newComicStore.latitude = latitude
        newComicStore.longitude = longitude
        
        do {
            try context.save()
        } catch {
            print( "Fail" )
        }

    }
    
    func fetch() -> [ ComicStore ] {
        let request: NSFetchRequest<ComicStore> = ComicStore.fetchRequest()
        var comicStores: [ ComicStore ] = []
        
        do {
            comicStores = try context.fetch( request )
        } catch {
            print( "Failed when fetch..." )
        }
        return comicStores
    }
 
    func update( annotation: MarvelAnnotation, newAnnotation: MarvelAnnotation ) {
        let request: NSFetchRequest<ComicStore> = ComicStore.fetchRequest()
        // request.predicate( format: "annotation = %@", annotation )
    }
    
    private func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
}
