//
//  ServicoListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 27/09/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct ServicoListaView: View
{
    @StateObject private var viewModel = ServicoViewModel()
    let router = MyRouter.shared
    
    var body: some View
    {
        VStack
        {
            HeaderAddView(nomeView: "Lista serviço", nomeMenu: "Menu", destRouter: "serv", backRouter: "cadastros")
            List
            {
                ForEach(viewModel.servicosLista, id: \.self) { servico in
                    HStack
                    {
                        Text(String(servico.nome ?? ""))
                        Spacer()
                        Text(String(servico.nomeCategoria))
                    }.onTapGesture { editServicos(servico: servico)}
                }.onDelete(perform: deleteServicos)
            }
            Spacer()
        }
    }
    
    func editServicos(servico: Servico)
    {
        router.toServico(servico: servico, isEdit: true)
    }
    
    func deleteServicos(at offsets: IndexSet)
    {
        for offset in offsets
        {
            let servico = viewModel.servicosLista[offset]
            viewModel.delete(servico: servico)
        }
    }
}

extension Servico
{
    @objc
    var nomeCategoria: String
    {
        self.daCategoria?.nome ?? "não informado"
    }
}
