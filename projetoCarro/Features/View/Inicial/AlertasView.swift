//
//  Alertas.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct AlertasView: View 
{
    let router = MyRouter.shared
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HeaderView(nomeView: "Alertas", nomeMenu: "Menu")
            VStack()
            {
                MenuRow(titulo: "Config alerta")
                    .onTapGesture
                    {
                        router.toAlertaDetalhe()
                    }
                ForEach(0 ..< 4)
                { item in
                    MenuRow(titulo: "Alertas")
                }
            }.padding()
            Spacer()
        }
    }
}

