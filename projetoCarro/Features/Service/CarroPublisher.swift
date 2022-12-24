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

    var publisherContext: NSManagedObjectContext = {
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
            managedObjectContext: publisherContext,
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
        let newCarro = Carro(context: publisherContext)
        newCarro.id = carro.id
        newCarro.nome = carro.nome
        newCarro.marca = carro.marca
        newCarro.modelo = carro.modelo
        newCarro.placa = carro.placa
        newCarro.chassis = carro.chassis
        newCarro.ano = carro.ano

        publisherContext.performAndWait
        {
            do
            {
                try self.publisherContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }
    }

    func update(carro: Carro)
    {
        publisherContext.performAndWait
        {
            do
            {
                try self.publisherContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }
    }

    func delete(carro: Carro)
    {
        publisherContext.performAndWait
        {
            publisherContext.delete(carro)
            do
            {
                try self.publisherContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }
    }
    
    func inserePadrao()
    {
        let newCarro = Carro(context: publisherContext)
            newCarro.id = UUID()
            newCarro.nome = "padrão"
            newCarro.marca = "padrão"
            newCarro.modelo = "padrão"
            newCarro.placa = "padrão"
            newCarro.chassis = "padrão"
            newCarro.ano = Int16(0)
        
        publisherContext.performAndWait
        {
            do
            {
                try self.publisherContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }

        ModeloGlobal.shared.carroAtual = newCarro
    }

    func selecionarCarroAtivo()
    {
        let fetchRequest: NSFetchRequest<Carro> = Carro.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(ativo == 1)")
        fetchRequest.fetchLimit = 1

        do
        {
            logger.log("Context has changed, buscando carro atual")
            guard let carroAtual = try publisherContext.fetch(fetchRequest).first
            else { return }
            ModeloGlobal.shared.carroAtual = carroAtual
        }
        catch
        {
            fatalError("Erro moc \(error.localizedDescription)")
        }
    }

    func marcarCarroAtivo(ativoID: NSManagedObjectID)
    {
        // Desmarcar o ativo
        logger.log("Context has changed, marcando carro atual")

        let entityDescription = NSEntityDescription.entity(forEntityName: "Carro", in: publisherContext)
        let batchUpdateRequest = NSBatchUpdateRequest(entity: entityDescription!)
        
        batchUpdateRequest.resultType = .updatedObjectIDsResultType
        batchUpdateRequest.propertiesToUpdate = ["ativo": NSNumber(value: false)]
        
        do
        {
            let batchUpdateResult = try publisherContext.execute(batchUpdateRequest) as! NSBatchUpdateResult
            
            let objectIDs = batchUpdateResult.result as! [NSManagedObjectID]
            
            for objectID in objectIDs
            {
                // Turn Managed Objects into Faults
                let managedObject = publisherContext.object(with: objectID)
                publisherContext.refresh(managedObject, mergeChanges: false)
            }

            try self.carroFetchController.performFetch()
            
        }
        catch
        {
            let updateError = error as NSError
            print("\(updateError), \(updateError.userInfo)")
        }
        // TODO: verificar por ID
        do
        {
            let object = try publisherContext.existingObject(with: ativoID)
            logger.log("Context has changed, buscando carro atual")
            object.setValue(true, forKey: "ativo")
            update(carro: object as! Carro)

            ModeloGlobal.shared.carroAtual = object as? Carro
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
    }
}
