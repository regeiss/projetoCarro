//
//  ContentView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI
import CoreData
import NavigationStack

struct ContentView: View 
{
    var body: some View 
    {
        NavigationStackView ()
        {
            MenuScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider 
{
    static var previews: some View 
    {
        ContentView()
    }
}
