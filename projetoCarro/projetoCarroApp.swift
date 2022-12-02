//
//  projetoCarroApp.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI
import CoreData

final class modeloGlobal: ObservableObject
{
    static let shared = modeloGlobal()
    var ultimaKM: Int32 = 1
    var carroAtual: Carro?
}

@main
@available(iOS 16.0, *)
struct projetoCarroApp: App
{
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    static let persistenceController = PersistenceController.shared
    @StateObject var AppVars = modeloGlobal()
    @StateObject var loginStateController = LoginStateController()
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView(showMenu: false)
                .environment(\.managedObjectContext, projetoCarroApp.persistenceController.container.viewContext)
                .environmentObject(AppVars)
                .environmentObject(loginStateController)
                .modifier(DarkModeViewModifier())
        }.onChange(of: scenePhase)
        { phase in
            switch phase
            {
            case .active:
                print("active")
                getCoreDataDBPath()
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                saveContext()
            @unknown default:
                fatalError()
            }
        }
    }
    
    func saveContext()
    {
        let context = moc
        if context.hasChanges
        {
            do
            {
                try context.save()
            }
            catch
            {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getCoreDataDBPath()
    {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print("Core Data DB Path :: \(path ?? "Not found")")
    }
}

