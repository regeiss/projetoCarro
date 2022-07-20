//
//  Alertas.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI
import NavigationStack

struct AlertasView: View 
{
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HeaderView(nomeView: "Alertas", nomeMenu: "Menu")
            VStack()
            {
                ForEach(0 ..< 5) { item in
                    MenuRow(titulo: "Älertas")
                }
            }.padding()
            Spacer()
        }
    }
}

struct Alertas_Previews: PreviewProvider 
{
    static var previews: some View 
    {
        AlertasView()
    }
}
