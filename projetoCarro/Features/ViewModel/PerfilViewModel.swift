//
//  PerfilViewModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 21/09/22.
//

import Foundation
import Combine
import CoreData

class PerfilViewModel: ObservableObject
{
    @Published var perfilLista: [Perfil] = []

    private var bag: AnyCancellable?

    init(perfilPublisher: AnyPublisher<[Perfil], Never> = PerfilPublisher.shared.perfilCVS.eraseToAnyPublisher())
    {
        bag = perfilPublisher.sink { [unowned self] perfilsLista in
            self.perfilLista = perfilsLista
        }
    }

    func add(perfil: NovoPerfil)
    {
        PerfilPublisher.shared.add(perfil: perfil)
    }

    func update(perfil: Perfil)
    {
        PerfilPublisher.shared.update(perfil: perfil)
    }

    func delete(perfil: Perfil)
    {
        PerfilPublisher.shared.delete(perfil: perfil)
    }
    
    func inserePadrao()
    {
        PerfilPublisher.shared.inserePadrao()
    }
    
    func selecionarPerfilAtivo()
    {
        PerfilPublisher.shared.selecionarPerfilAtivo()
    }
    
    func marcarPerfilAtivo(ativoID: NSManagedObjectID)
    {
        PerfilPublisher.shared.marcarPerfilAtivo(ativoID: ativoID)
    }
}

