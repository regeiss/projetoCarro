//
//  ListaItemServicoView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 16/10/22.
//
import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct ItemServicoListaView: View
{
    @StateObject private var viewModel = ItemServicoViewModel()
    
    var body: some View
    {
        VStack
        {
            HeaderAddView(nomeView: "Lista itens serviço", nomeMenu: "Menu", destRouter: "item", backRouter: "cadastros")
            List
            {
                ForEach(viewModel.itemServicoLista, id: \.self) { itemServico in
                    HStack
                    {
                        Text(String(itemServico.nome ?? ""))
                        Spacer()
                        Text(String(itemServico.nomeServico))
                    }
                } .onDelete(perform: deleteItemServicos)
            }
            Spacer()
        }
    }
    
    func deleteItemServicos(at offsets: IndexSet)
    {
        for offset in offsets
        {
            let itemServico = viewModel.itemServicoLista[offset]
            viewModel.delete(itemServico: itemServico)
        }
    }
}

extension ItemServico
{
    @objc
    var nomeServico: String
    {
        self.doServico?.nome ?? "não informado"
    }
    
}
