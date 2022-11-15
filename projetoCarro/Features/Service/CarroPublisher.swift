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
}

extension CarroPublisher: NSFetchedResultsControllerDelegate
{
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        guard let carros = controller.fetchedObjects as? [Carro]
        else { return}
        logger.log("Context has changed, reloading carros")
        self.carroCVS.value = carros
    }
}
