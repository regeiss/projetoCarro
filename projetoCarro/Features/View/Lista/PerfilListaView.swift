//
//  PerfilListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 26/12/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct PerfilListaView: View
{
    @StateObject private var viewModel = PerfilViewModel()
    let router = MyRouter.shared
    
    var body: some View
    {
        VStack
        {
            HeaderAddView(nomeView: "Lista perfis", nomeMenu: "Menu", destRouter: "perfil", backRouter: "cadastros")
            List
            {
                ForEach(viewModel.perfilLista, id: \.self) { perfil in
                    HStack
                    {
                        Text(String(perfil.nome ?? ""))
                        Spacer()
                        Text(perfil.ativo ? "ativo" : " ").foregroundColor(.blue)
                    }.onTapGesture
                    {
                        editPerfil(perfil: perfil)
                    }
                }.onDelete(perform: deletePerfil)

            }
            Spacer()
        }
    }
    
    func editPerfil(perfil: Perfil)
    {
        router.toPerfil(perfil: perfil, isEdit: true)
    }
    
    func deletePerfil(at offsets: IndexSet)
    {
        for offset in offsets
        {
            let perfil = viewModel.perfilLista[offset]
            viewModel.delete(perfil: perfil)
        }
    }
}

