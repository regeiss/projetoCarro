//
//  projetoCarroApp.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI

@main
struct projetoCarroApp: App
{
    let persistenceController = PersistenceController.shared
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
