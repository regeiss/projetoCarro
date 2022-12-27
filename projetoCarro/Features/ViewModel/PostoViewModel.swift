//
//  PostoViewModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 30/08/22.
//

import Foundation
import Combine
import CoreData

class PostoViewModel: ObservableObject
{
    @Published var postosLista: [Posto] = []

    private var bag: AnyCancellable?

    init(postoPublisher: AnyPublisher<[Posto], Never> = PostoPublisher.shared.postoCVS.eraseToAnyPublisher())
    {
        bag = postoPublisher.sink { [unowned self] postosLista in
            self.postosLista = postosLista
        }
    }

    func add(posto: NovoPosto)
    {
        PostoPublisher.shared.add(posto: posto)
    }

    func update(posto: Posto)
    {
        PostoPublisher.shared.update(posto: posto)
    }
    
    func delete(posto: Posto)
    {
        PostoPublisher.shared.delete(posto: posto)
    }
    
    func inserePadrao()
    {
        PostoPublisher.shared.inserePadrao()
    }
    
    func selecionarPostoPadrao()
    {
        PostoPublisher.shared.selecionarPostoPadrao()
    }
}
