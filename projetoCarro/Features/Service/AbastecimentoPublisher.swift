//
//  AbastecimentoController.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 26/07/22.
//
// https://mattrighetti.com/2021/02/03/swiftui-and-coredata-mvvm.html

import Foundation
import CoreData
import Combine
import OSLog
import SwiftUI

class AbastecimentoPublisher: NSObject, ObservableObject
{
    static let shared = AbastecimentoPublisher()
    var abastecimentoCVS = CurrentValueSubject<[Abastecimento], Never>([])
    private let abastecimentoFetchController: NSFetchedResultsController<Abastecimento>
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")
    
    var backgroundContext: NSManagedObjectContext = {
        let context = PersistenceController.shared.container.viewContext
             context.mergePolicy = NSMergePolicy( merge: .mergeByPropertyObjectTrumpMergePolicyType)
             context.automaticallyMergesChangesFromParent = true
         return context
         }()
    
    private override init() 
    {
        @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
        let fetchRequest: NSFetchRequest<Abastecimento> = Abastecimento.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "data", ascending: false)

        fetchRequest.sortDescriptors = [sortDescriptor]

        abastecimentoFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,  
            managedObjectContext: backgroundContext,
            sectionNameKeyPath: nil, cacheName: nil
        )

        super.init()

        abastecimentoFetchController.delegate = self

        do 
        {
            try abastecimentoFetchController.performFetch()
            abastecimentoCVS.value = abastecimentoFetchController.fetchedObjects ?? []
        } 
        catch 
        {
            NSLog("Erro: could not fetch objects")
        }
    }

    func add(abastecimento: ultimoAbastecimento)
    {
        let newAbastecimento = Abastecimento(context: backgroundContext)
        
        newAbastecimento.id = abastecimento.id
        newAbastecimento.km = abastecimento.km
        newAbastecimento.completo = abastecimento.completo
        newAbastecimento.litros = abastecimento.litros
        newAbastecimento.data = abastecimento.data
        newAbastecimento.valorLitro = abastecimento.valorLitro        
        newAbastecimento.valorTotal = abastecimento.litros * abastecimento.valorLitro
        newAbastecimento.media = abastecimento.media
        newAbastecimento.doPosto = abastecimento.doPosto
        newAbastecimento.doCarro = abastecimento.doCarro
        
        backgroundContext.performAndWait
        {
            do
            {
                try backgroundContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }
    }

    func update(abastecimento: Abastecimento)
    {
        //...
    }

    func delete(abastecimento: Abastecimento)
    {
        backgroundContext.performAndWait
        {
            backgroundContext.delete(abastecimento)
            do
            {
                try backgroundContext.save()
            }
            catch
            {
                fatalError("Erro moc \(error.localizedDescription)")
            }
        }
    }
}

extension AbastecimentoPublisher: NSFetchedResultsControllerDelegate 
{
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) 
    {
        guard let abastecimentos = controller.fetchedObjects as? [Abastecimento] 
        else { return }
        logger.log("Context has changed, reloading abastecimento")
        self.abastecimentoCVS.value = abastecimentos
    }
}

