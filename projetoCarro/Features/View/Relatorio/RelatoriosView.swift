//
//  Relatorios.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct RelatoriosView: View 
{
    let router = MyRouter.shared
    
    var body: some View 
    {
        VStack(alignment: .leading)
        {
            HeaderView(nomeView: "Relatórios", nomeMenu: "Menu")
            VStack()
            {
                MenuRow(titulo: "Serviços")
                    .onTapGesture
                    {
                        router.toRelServico()
                    }
                MenuRow(titulo: "Consumo")
                    .onTapGesture
                    {
                        router.toRelConsumo()
                    }
                MenuRow(titulo: "Combustível")
                    .onTapGesture
                    {
                        router.toRelCombustivel()
                    }
                MenuRow(titulo: "Gráficos")
                    .onTapGesture
                    {
                        router.toGraficos()
                    }
            }.padding()
            Spacer()
        }
    }
}
