//
//  ItemServicoViewModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 21/10/22.
//

import Foundation
import Combine
import CoreData

class ItemServicoViewModel: ObservableObject
{
    @Published var itemServicoLista: [ItemServico] = []

    private var bag: AnyCancellable?

    init(itemServPublisher: AnyPublisher<[ItemServico], Never> = ItemServicoPublisher.shared.itemServicoCVS.eraseToAnyPublisher())
    {
        bag = itemServPublisher.sink { [unowned self] itemServicoLista in
            self.itemServicoLista = itemServicoLista
        }
    }

    func add(itemServico: NovoItemServico)
    {
        ItemServicoPublisher.shared.add(itemServico: itemServico)
    }

    func delete(itemServico: ItemServico)
    {
        ItemServicoPublisher.shared.delete(itemServico: itemServico)
    }

    func filter(tipo: String)
    {
        ItemServicoPublisher.shared.filter(tipo: tipo)
    }
}
