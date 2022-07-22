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
    @StateObject private var dataController = DataController()
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
