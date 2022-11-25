//
//  CarroPublisher.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 01/09/22.
//

import Foundation
import CoreData
import Combine
import OSLog
import SwiftUI

class CarroPublisher: NSObject, ObservableObject
{
    static let shared = CarroPublisher()
    var carroCVS = CurrentValueSubject<[Carro], Never>([])
    private let carroFetchController: NSFetchedResultsController<Carro>
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")

    var backgroundContext: NSManagedObjectContext = {
         let context = PersistenceController.shared.container.viewContext 
             context.mergePolicy = NSMergePolicy( merge: .mergeByPropertyObjectTrumpMergePolicyType)
             context.automaticallyMergesChangesFromParent = true
         return context
         }()

    private override init()
    {
        let fetchRequest: NSFetchRequest<Carro> = Carro.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: false)

        fetchRequest.sortDescriptors = [sortDescriptor]

        carroFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: backgroundContext,
            sectionNameKeyPath: nil, cacheName: nil
        )

        super.init()

        carroFetchController.delegate = self

        do
        {
            try carroFetchController.performFetch()
            carroCVS.value = carroFetchController.fetchedObjects ?? []
        }
        catch
        {
            NSLog("Erro: could not fetch objects")
        }
    }

    func add(carro: NovoCarro)
    {
        let newCarro = Carro(context: backgroundContext)
        newCarro.id = carro.id
        newCarro.nome = carro.nome
        newCarro.marca = carro.marca
        newCarro.modelo = carro.modelo
        newCarro.placa = carro.placa
        newCarro.chassis = carro.chassis
        newCarro.ano = carro.ano

        backgroundContext.performAndWait
        {
            do
            {
                try self.backgroundContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }
    }

    func update(carro: Carro)
    {
        backgroundContext.performAndWait
        {
            do
            {
                try self.backgroundContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }
    }

    func delete(carro: Carro)
    {
        backgroundContext.performAndWait
        {
            backgroundContext.delete(carro)
            do
            {
                try self.backgroundContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }
    }
    
    func selecionarCarroAtivo()
    {
        // 

        let fetchRequest: NSFetchRequest<Carro> = Carro.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(ativo == 1)")
        fetchRequest.fetchLimit = 1

        // TODO: verificar por ID
        do
        {
            logger.log("Context has changed, buscando carro atual")
            guard let carroAtual = try backgroundContext.fetch(fetchRequest).first
            else { return}
            modeloGlobal.shared.carroAtual = carroAtual
        }
        catch
        {
            fatalError("Erro moc \(error.localizedDescription)")
        }
    }
    //==============================================================================================================================================================
    // 25/11/2022 - 14:32
    func marcarCarroAtivo()
    {
        // Desmarcar o ativo 
//     persistentContainer.performBackgroundTask { privateManagedObjectContext in
// 	// Creates new batch update request for entity `Dog`
// 	let updateRequest = NSBatchUpdateRequest(entityName: "Dog")
// 	// All the dogs with `isFavorite` true
// 	let predicate = NSPredicate(format: "ativo == true")
// 	// Assigns the predicate to the batch update
// 	updateRequest.predicate = predicate

// 	// Dictionary with the property names to update as keys and the new values as values
// 	updateRequest.propertiesToUpdate = ["ativo": false]

// 	// Sets the result type as array of object IDs updated
// 	updateRequest.resultType = .updatedObjectIDsResultType

// 	do {
// 		// Executes batch
// 		let result = try privateManagedObjectContext.execute(updateRequest) as? NSBatchUpdateResult

// 		// Retrieves the IDs updated
// 		guard let objectIDs = result?.result as? [NSManagedObjectID] else { return }

// 		// Updates the main context
// 		let changes = [NSUpdatedObjectsKey: objectIDs]
// 		NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [mainManagedObjectContext])
// 	} catch {
// 		fatalError("Failed to execute request: \(error)")
// 	}
// }
//
// func checkAll(sender: UIBarButtonItem) { 
//     // Create Entity Description
//     let entityDescription = NSEntityDescription.entityForName("Item", inManagedObjectContext: managedObjectContext)
     
//     // Initialize Batch Update Request
//     let batchUpdateRequest = NSBatchUpdateRequest(entity: entityDescription!)
     
//     // Configure Batch Update Request
//     batchUpdateRequest.resultType = .UpdatedObjectIDsResultType
//     batchUpdateRequest.propertiesToUpdate = ["done": NSNumber(bool: true)]
     
//     do {
//         // Execute Batch Request
//         let batchUpdateResult = try managedObjectContext.executeRequest(batchUpdateRequest) as! NSBatchUpdateResult
         
//         // Extract Object IDs
//         let objectIDs = batchUpdateResult.result as! [NSManagedObjectID]
         
//         for objectID in objectIDs {
//             // Turn Managed Objects into Faults
//             let managedObject = managedObjectContext.objectWithID(objectID)
//             managedObjectContext.refreshObject(managedObject, mergeChanges: false)
//         }
         
//         // Perform Fetch
//         try self.fetchedResultsController.performFetch()
         
//     } catch {
//         let updateError = error as NSError
//         print("\(updateError), \(updateError.userInfo)")
//     }
// }
    }

//=========================================================================================================================================================
        let fetchRequest: NSFetchRequest<Carro> = Carro.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(ativo == 1)")
        fetchRequest.fetchLimit = 1

        // TODO: verificar por ID

// var error: NSError?
// if let object = managedObjectContext.existingObjectWithID(objectID, error: &error) {
//     // do something with it
// }
// else {
//     println("Can't find object \(error)")
// }
        do
        {
            logger.log("Context has changed, buscando carro atual")
            guard let carroAtual = try backgroundContext.fetch(fetchRequest).first
            else { return}
            modeloGlobal.shared.carroAtual = carroAtual
        }
        catch
        {
            fatalError("Erro moc \(error.localizedDescription)")
        }
    }
}

extension CarroPublisher: NSFetchedResultsControllerDelegate
{
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        guard let carros = controller.fetchedObjects as? [Carro]
        else { return}
        logger.log("Context has changed, reloading carros")
        self.carroCVS.value = carros
        modeloGlobal.shared.carroAtual = carros[0]
    }
}
