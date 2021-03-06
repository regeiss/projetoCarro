//
//  DataController.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 23/07/22.
//

import Foundation
import CoreData

class DataController: ObservableObject
{
    let container = NSPersistentContainer(name: "Abastecimento")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
