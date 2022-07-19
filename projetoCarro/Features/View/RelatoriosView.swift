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
                ForEach(0 ..< 6) { item in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
                        .frame(height: 100)
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
