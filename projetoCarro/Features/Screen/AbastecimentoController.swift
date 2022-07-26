//
//  AbastecimentoController.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 26/07/22.
//

import Foundation
import CoreData


class TodoItemStorage: NSObject, ObservableObject {
  @Published var dueSoon: [TodoItem] = []
  private let dueSoonController: NSFetchedResultsController<TodoItem>

  init(managedObjectContext: NSManagedObjectContext) {
    dueSoonController = NSFetchedResultsController(fetchRequest: TodoItem.dueSoonFetchRequest,
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
    guard let todoItems = controller.fetchedObjects as? [TodoItem]
      else { return }

    dueSoon = todoItems
  }
}

//struct MainView: View {
//  @ObservedObject var todoItemStore: TodoItemStorage
//
//  var body: some View {
//    List(todoItemStore.dueSoon) { item in
//      return Text(item.name)
//    }
//  }
//}
