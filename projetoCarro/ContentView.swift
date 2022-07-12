//
//  ContentView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI
import NavigationStack

struct ContentView: View 
{
    var body: some View 
    {
        NavigationStackView (transitionType: .custom(.scale), easing: .spring(response: 0.5, dampingFraction: 0.25, blendDuration: 0.5))
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
