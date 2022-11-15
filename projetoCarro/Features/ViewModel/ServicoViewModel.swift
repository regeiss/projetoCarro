//
//  ServicoViewModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 27/09/22.
//

import Foundation
import Combine
import CoreData

class ServicoViewModel: ObservableObject
{
    @Published var servicosLista: [Servico] = []

    private var bag: AnyCancellable?

    init(servicoPublisher: AnyPublisher<[Servico], Never> = ServicoPublisher.shared.servicoCVS.eraseToAnyPublisher())
    {
        bag = servicoPublisher.sink { [unowned self] servicosLista in
            self.servicosLista = servicosLista
        }
    }

    func update(servico: Servico)
    {
        ServicoPublisher.shared.update(servico: servico)
    }
    
    func add(servico: NovoServico)
    {
        ServicoPublisher.shared.add(servico: servico)
    }

    func delete(servico: Servico)
    {
        ServicoPublisher.shared.delete(servico: servico)
    }
}

