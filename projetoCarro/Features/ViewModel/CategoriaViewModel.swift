//
//  CategoriaViewModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 27/09/22.
//

import Foundation
import Combine
import CoreData

class CategoriaViewModel: ObservableObject
{
    @Published var categoriasLista: [Categoria] = []

    private var bag: AnyCancellable?

    init(abastPublisher: AnyPublisher<[Categoria], Never> = CategoriaPublisher.shared.categoriaCVS.eraseToAnyPublisher())
    {
        bag = abastPublisher.sink { [unowned self] categoriasLista in
            self.categoriasLista = categoriasLista
        }
    }
    
    func update(categoria: Categoria)
    {
        CategoriaPublisher.shared.update(categoria: categoria)
    }

    func add(categoria: NovaCategoria)
    {
        CategoriaPublisher.shared.add(categoria: categoria)
    }

    func delete(categoria: Categoria)
    {
        CategoriaPublisher.shared.delete(categoria: categoria)
    }
}

