//
//  CoreDataConnection.swift
//  CoreDataPractice
//
//  Created by Hungju Lu on 01/12/2016.
//  Copyright © 2016 Hungju. All rights reserved.
//

import UIKit
import CoreData

fileprivate struct CoreDataEntityName {
    static let person = "Person"
}

fileprivate struct CoreDataPropertyName {
    static let name = "name"
}

public class CoreDataConnection: NSObject {
    
    public func insertPerson(withName name: String) -> Bool {
        let newData = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntityName.person, into: self.context)
        
        newData.setValue(name, forKey: CoreDataPropertyName.name)
        
        do {
            try self.context.save()
            return true
        } catch {
            fatalError("\(error)")
        }
        
        return false
    }
    
    public func reterivePeople(sortedByName: Bool) -> [Person]? {
        let request = NSFetchRequest<Person>(entityName: CoreDataEntityName.person)
        
        if sortedByName {
            request.sortDescriptors = [NSSortDescriptor(key: CoreDataPropertyName.name, ascending: true)]
        }
        
        do {
            return try self.context.fetch(request)
        } catch {
            fatalError("\(error)")
        }
        
        return nil
    }
    
    // MARK: - Core Data stack
    
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataPractice")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    fileprivate var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    fileprivate func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
