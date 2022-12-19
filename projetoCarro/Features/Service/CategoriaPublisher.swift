//
//  CategoriaPublisher.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 27/09/22.
//

import Foundation
import CoreData
import Combine
import OSLog
import SwiftUI

class CategoriaPublisher: NSObject, ObservableObject
{
    static let shared = CategoriaPublisher()
    var categoriaCVS = CurrentValueSubject<[Categoria], Never>([])
    private let categoriaFetchController: NSFetchedResultsController<Categoria>
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")

    var backgroundContext: NSManagedObjectContext = {
         let context = PersistenceController.shared.container.viewContext 
             context.mergePolicy = NSMergePolicy( merge: .mergeByPropertyObjectTrumpMergePolicyType)
             context.automaticallyMergesChangesFromParent = true
         return context
         }()

    private override init()
    {
        let fetchRequest: NSFetchRequest<Categoria> = Categoria.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: false)

        fetchRequest.sortDescriptors = [sortDescriptor]

        categoriaFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: backgroundContext,
            sectionNameKeyPath: nil, cacheName: nil
        )

        super.init()

        categoriaFetchController.delegate = self

        do
        {
            try categoriaFetchController.performFetch()
            categoriaCVS.value = categoriaFetchController.fetchedObjects ?? []
        }
        catch
        {
            NSLog("Erro: could not fetch objects")
        }
    }

    func add(categoria: NovaCategoria)
    {
        let newCategoria = Categoria(context: backgroundContext)
        newCategoria.id = categoria.id
        newCategoria.nome = categoria.nome
        newCategoria.nomeImagem = categoria.nomeImagem

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

    func update(categoria: Categoria)
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

    func delete(categoria: Categoria)
    {
        backgroundContext.performAndWait
        {
            backgroundContext.delete(categoria)
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

extension CategoriaPublisher: NSFetchedResultsControllerDelegate
{
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        guard let categorias = controller.fetchedObjects as? [Categoria]
        else { return}
        logger.log("Context has changed, reloading categorias")
        self.categoriaCVS.value = categorias
    }
}
