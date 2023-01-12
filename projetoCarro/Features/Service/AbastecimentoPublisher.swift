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
    
    var publisherContext: NSManagedObjectContext = {
         let context = PersistenceController.shared.container.viewContext
             context.mergePolicy = NSMergePolicy( merge: .mergeByPropertyObjectTrumpMergePolicyType)
             context.automaticallyMergesChangesFromParent = true
         return context
         }()
    
    private override init() 
    {
        let fetchRequest: NSFetchRequest<Abastecimento> = Abastecimento.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "data", ascending: false)

        fetchRequest.sortDescriptors = [sortDescriptor]

        abastecimentoFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,  
            managedObjectContext: publisherContext,
            sectionNameKeyPath: #keyPath(Abastecimento.data), cacheName: nil
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
        let newAbastecimento = Abastecimento(context: publisherContext)
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

    func update(abastecimento: Abastecimento)
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

    func delete(abastecimento: Abastecimento)
    {
        publisherContext.performAndWait
        {
            publisherContext.delete(abastecimento)
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

//    // MARK:- sectioned dictionary
//    func getSectionedDictionary() -> Dictionary <String , [Abastecimento]>
//    {
//        let sectionDictionary: Dictionary<String, [Abastecimento]> = {
//            return Dictionary(grouping: abastecimentos, by: {
//
//                let dataAbastecimento = $0.data
//                let calendar = Calendar.current
//                let components = calendar.dateComponents([.year], from: dataAbastecimento)
//                let year = components.year
//                let normalizedDate = String(year!)
//                return normalizedDate
//            })
//        }()
//        return sectionDictionary
//    }
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

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

//let date = Date()
//
//// MARK: Way 1
//
//let components = date.get(.day, .month, .year)
//if let day = components.day, let month = components.month, let year = components.year {
//    print("day: \(day), month: \(month), year: \(year)")
//}

// MARK: Way 2

//print("day: \(date.get(.day)), month: \(date.get(.month)), year: \(date.get(.year))")
// https://betterprogramming.pub/how-to-section-lists-alphabetically-in-swiftui-e841f35993f
// https://www.zerotoappstore.com/get-year-month-day-from-date-swift.html
