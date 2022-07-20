//
//  Relatorios.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI
import NavigationStack

struct RelatoriosView: View 
{
    var body: some View 
    {
        VStack(alignment: .leading)
        {
            HeaderView(nomeView: "Relatórios", nomeMenu: "Menu")
            VStack()
            {
                ForEach(0 ..< 5) { item in
                    MenuRow(titulo: "Relatorios")
                }
                
            }.padding()
            Spacer()
        }
    }
}

struct Relatorios_Previews: PreviewProvider 
{
    static var previews: some View 
    {
        RelatoriosView()
    }
}
