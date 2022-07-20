//
//  Servicos.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI
import NavigationStack

struct ServicosView: View
{
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HeaderView(nomeView: "Serviços", nomeMenu: "Menu")
            VStack()
            {
                ForEach(0 ..< 5) { item in
                    MenuRow(titulo: "Servicos")
                }
                
            }.padding()
            Spacer()
        }
    }
}

struct Servicos_Previews: PreviewProvider
{
    static var previews: some View
    {
        ServicosView()
    }
}
