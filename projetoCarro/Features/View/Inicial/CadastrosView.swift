//
//  CadastrosView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 05/10/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct CadastrosView: View
{
    let router = MyRouter.shared
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HeaderView(nomeView: "Cadastros", nomeMenu: "Menu")
            VStack()
            {
                MenuRow(titulo: "Categorias")
                    .onTapGesture
                    {
                        router.toListaCategoria()
                    }
                MenuRow(titulo: "Serviços")
                    .onTapGesture
                    {
                        router.toListaServico()
                    }
                MenuRow(titulo: "Carros")
                    .onTapGesture
                    {
                        router.toListaCarro()
                    }
                MenuRow(titulo: "Postos")
                    .onTapGesture
                    {
                        router.toListaPosto()
                    }
                
            }.padding()
            Spacer()
        }
    }
}
