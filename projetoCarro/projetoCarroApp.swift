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
    var perfilPadrao: Perfil?
    var postoPadrao: Posto?
}

@main
@available(iOS 16.0, *)
struct projetoCarroApp: App
{
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    
    @StateObject var appVars = ModeloGlobal()
    @AppStorage("contextSet") private var contextSet: Bool = false
    
    static let persistenceController = PersistenceController.shared
    
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
                prepareAppContext()
                setAppVars()
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
    
    func prepareAppContext()
    {
        guard contextSet == false
        else { return }
        
        let viewModelPerfil = PerfilViewModel()
        let viewModelCarro = CarroViewModel()
        let viewModelPosto = PostoViewModel()
        
        // Inserir perfil padrão
        viewModelPerfil.inserePadrao()
        viewModelCarro.inserePadrao()
        viewModelPosto.inserePadrao()

        contextSet = true
    }
    
    func setAppVars()
    {
        let viewModelPerfil = PerfilViewModel()
        let viewModelCarro = CarroViewModel()
        let viewModelPosto = PostoViewModel()
        
        viewModelCarro.selecionarCarroAtivo()
        viewModelPosto.selecionarPostoPadrao()
        viewModelPerfil.selecionarPerfilPadrao()
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







