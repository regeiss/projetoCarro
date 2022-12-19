//
//  Persistence.swift
//  testeCoreData
//
//  Created by Roberto Edgar Geiss on 20/07/22.
//

import CoreData

struct PersistenceController
{
    static let shared = PersistenceController()
    let container: NSPersistentContainer
        init(inMemory: Bool = false) {
            container = NSPersistentContainer(name: "projetoCoreData")
            if inMemory
            {
                container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            }
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError?
                {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
}
