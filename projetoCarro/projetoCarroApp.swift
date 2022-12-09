//
//  projetoCarroApp.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI
import CoreData

final class ModeloGlobal: ObservableObject
{
    static let shared = ModeloGlobal()
    var ultimaKM: Int32 = 1
    var carroAtual: Carro?
    var perfilAtual: Perfil?
    var contextSet = false 
}

@main
@available(iOS 16.0, *)
struct projetoCarroApp: App
{
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    static let persistenceController = PersistenceController.shared
    @StateObject var appVars = ModeloGlobal()
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView(showMenu: false)
                .environment(\.managedObjectContext, projetoCarroApp.persistenceController.container.viewContext)
                .environmentObject(appVars)
                .modifier(DarkModeViewModifier())
                .withErrorHandling()
        }
        .onChange(of: scenePhase)
        { phase in
            switch phase
            {
            case .active:
                print("active")
                prepareContext()
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
    
    func prepareContext()
    {
        guard appVars.contextSet == false
        else { return}

        appVars.contextSet.toggle()
        var viewModelPerfil = PerfilViewModel()
        var viewModelCarro = CarroViewModel()
        
        let perfil = NovoPerfil(id: UUID(),
                                    nome: "Nenhum",
                                    email: "nenhum",
                                    padrao: true)

                            viewModelPerfil.add(perfil: perfil)

               let carro = NovoCarro(id: UUID(),
                                      nome: "Nenhum",
                                      marca: "Nenhum",
                                      modelo: "Nenhum",
                                      placa: "Nenhum",
                                      chassis: "Nenhum",
                                      padrao: true,
                                      ano: Int16(0))
                viewModelCarro.add(carro: carro)
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



