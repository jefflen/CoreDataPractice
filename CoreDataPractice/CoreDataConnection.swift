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
    
    var context: NSManagedObjectContext! = nil
    
    init(context: NSManagedObjectContext) {
        super.init()
        self.context = context
    }
    
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
}
