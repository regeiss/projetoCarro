//
//  CarroViewModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 01/09/22.
//

import Foundation
import Combine
import CoreData

class CarroViewModel: ObservableObject
{
    @Published var carrosLista: [Carro] = []

    private var bag: AnyCancellable?

    init(carroPublisher: AnyPublisher<[Carro], Never> = CarroPublisher.shared.carroCVS.eraseToAnyPublisher())
    {
        bag = carroPublisher.sink { [unowned self] carrosLista in
            self.carrosLista = carrosLista
        }
    }

    func selecionarCarroAtivo()
    {
        CarroPublisher.shared.selecionarCarroAtivo()
    }
    func update(carro: Carro)
    {
        CarroPublisher.shared.update(carro: carro)
    }
    
    func add(carro: NovoCarro)
    {
        CarroPublisher.shared.add(carro: carro)
    }

    func delete(carro: Carro)
    {
        CarroPublisher.shared.delete(carro: carro)
    }
}
