//
//  PostoListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 09/10/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct PostoListaView: View
{
    @StateObject private var viewModel = PostoViewModel()
    let router = MyRouter.shared
    
    var body: some View
    {
        VStack
        {
            HeaderAddView(nomeView: "Lista postos", nomeMenu: "Menu", destRouter: "post", backRouter: "cadastros")
            List
            {
                ForEach(viewModel.postosLista, id: \.self) { posto in
                    HStack
                    {
                        Text(String(posto.nome ?? ""))
                    }.onTapGesture {
                        editPostos(posto: posto)
                    }
                }.onDelete(perform: deletePostos)

            }
            Spacer()
        }
    }
    
    func editPostos(posto: Posto)
    {
        router.toPosto(posto: posto, isEdit: true)
    }
    
    func deletePostos(at offsets: IndexSet)
    {
        for offset in offsets
        {
            let posto = viewModel.postosLista[offset]
            viewModel.delete(posto: posto)
        }
    }
}

