//
//  DataController.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 23/07/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Abastecimento")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    func retornaUltimoABastecimento() -> Abastecimento
    {
        @Environment(\.managedObjectContext) var moc
        @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Abastecimento.data, ascending: true),
            predicate: NSPredicate(format: "date == max(date)")
        ]) 
        var abastecimento: FetchedResults<Abastecimento>
        return abastecimento
    }

    func readData() -> [ProgrammingLanguage] {
    let fetchRequest: NSFetchRequest<ProgrammingLanguage> = ProgrammingLanguage.fetchRequest()
    fetchRequest.sortDescriptor = NSSortDescriptor(keyPath: \ProgrammingLanguage.id, ascending: true)
    do {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext

        let languages = try managedObjectContext.fetch(fetchRequest)
        return languages
    } catch let error as NSError {
        print("Error fetching ProgrammingLanguages: \(error.localizedDescription), \(error.userInfo)")
    }
    return [ProgrammingLanguage]()
    }
}
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

struct MainView: View {
  @ObservedObject var todoItemStore: TodoItemStorage

  var body: some View {
    List(todoItemStore.dueSoon) { item in
      return Text(item.name)
    }
  }
}
