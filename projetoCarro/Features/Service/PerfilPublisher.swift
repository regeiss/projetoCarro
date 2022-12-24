//
//  PerfilPublisher.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 21/09/22.
//

import CoreData
import Combine
import OSLog
import SwiftUI

class PerfilPublisher: NSObject, ObservableObject
{
    static let shared = PerfilPublisher()
    var perfilCVS = CurrentValueSubject<[Perfil], Never>([])
    private let perfilFetchController: NSFetchedResultsController<Perfil>
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")
    
    var publisherContext: NSManagedObjectContext = {
        let context = PersistenceController.shared.container.viewContext
        context.mergePolicy = NSMergePolicy( merge: .mergeByPropertyObjectTrumpMergePolicyType)
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    private override init()
    {
        let fetchRequest: NSFetchRequest<Perfil> = Perfil.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.returnsDistinctResults = true
        
        perfilFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: publisherContext,
            sectionNameKeyPath: nil, cacheName: nil
        )
        
        super.init()
        
        perfilFetchController.delegate = self
        
        do
        {
            try perfilFetchController.performFetch()
            perfilCVS.value = perfilFetchController.fetchedObjects ?? []
        }
        catch
        {
            NSLog("Erro: could not fetch objects")
        }
    }
    
    func add(perfil: NovoPerfil)
    {
        let newPerfil = Perfil(context: publisherContext)
        newPerfil.id = perfil.id
        newPerfil.nome = perfil.nome
        newPerfil.email = perfil.email
        
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
    
    func update(perfil: Perfil)
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
    
    func delete(perfil: Perfil)
    {
        publisherContext.performAndWait
        {
            publisherContext.delete(perfil)
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
        let newPerfil = Perfil(context: publisherContext)
        newPerfil.id = UUID()
        newPerfil.nome = "Padrão"
        newPerfil.email = "padrão"
        
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
        
        ModeloGlobal.shared.perfilAtual = newPerfil
    }
}

extension PerfilPublisher: NSFetchedResultsControllerDelegate
{
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        guard let perfis = controller.fetchedObjects as? [Perfil]
        else { return }
        logger.log("Context has changed, reloading postos")
        self.perfilCVS.value = perfis
    }
}
