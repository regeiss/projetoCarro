//
//  CarroListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 09/10/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)

struct CarroListaView: View
{
    @StateObject private var viewModel = CarroViewModel()

    let router = MyRouter.shared
    
    var body: some View
    {
        VStack
        {
            HeaderAddView(nomeView: "Lista veículos", nomeMenu: "Menu", destRouter: "veic", backRouter: "cadastros")
            List
            {
                ForEach(viewModel.carrosLista, id: \.self) { carro in
                    
                        HStack
                        {
                            Label("car", systemImage: "car")
                                .labelStyle(.iconOnly)
                            VStack
                            {
                                HStack
                                {
                                    Text(String(carro.nome ?? ""))
                                    Spacer()
                                }
                            }
                        }.onTapGesture {
                            editCarros(carro: carro)
                        }
                }.onDelete(perform: deleteCarros)
                    
            }
            Spacer()
        }
    }

    func editCarros(carro: Carro)
    {
        router.toCarro(carro: carro, isEdit: true)
    }
    
    func deleteCarros(at offsets: IndexSet)
    {
        for offset in offsets
        {
            let carro = viewModel.carrosLista[offset]
            viewModel.delete(carro: carro)
        }
    }
}

