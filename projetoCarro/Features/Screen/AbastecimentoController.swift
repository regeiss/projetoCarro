//
//  AbastecimentoController.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 26/07/22.
//

import Foundation
import CoreData


class TodoItemStorage: NSObject, ObservableObject {
  @Published var dueSoon: [Abastecimento] = []
  private let dueSoonController: NSFetchedResultsController<Abastecimento>

  init(managedObjectContext: NSManagedObjectContext) {
    dueSoonController = NSFetchedResultsController(fetchRequest: Abastecimento.dueSoonFetchRequest,
    managedObjectContext: managedObjectContext,
    sectionNameKeyPath: nil, cacheName: nil)

    super.init()

    dueSoonController.delegate = self

    do {
      try dueSoonController.performFetch()
      dueSoon = dueSoonController.fetchedObjects ?? []
    } catch {
      print("failed to fetch items!")
    }
  }
}

extension TodoItemStorage: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let todoItems = controller.fetchedObjects as? [Abastecimento]
      else { return }

    dueSoon = todoItems
  }
}
extension Abastecimento {
  static var dueSoonFetchRequest: NSFetchRequest<Abastecimento> {
    let request: NSFetchRequest<Abastecimento> = Abastecimento.fetchRequest()
    request.predicate = NSPredicate(format: "dueDate < %@", Date() as CVarArg)
    request.sortDescriptors = [NSSortDescriptor(key: "dueDate", ascending: true)]

    return request
  }
}

// in your view
//@FetchRequest(fetchRequest: TodoItem.dueSoonFetchRequest)
//var tasksDueSoon: FetchedResults<TodoItem>

//struct MainView: View {
//  @ObservedObject var todoItemStore: TodoItemStorage
//
//  var body: some View {
//    List(todoItemStore.dueSoon) { item in
//      return Text(item.name)
//    }
//  }
//}
