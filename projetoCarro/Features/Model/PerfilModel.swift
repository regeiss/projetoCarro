//
//  PerfilModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 21/09/22.
//

import Foundation

struct NovoPerfil: Identifiable
{
    let id: UUID
    let nome: String
    let email: String
    let ativo: Bool
    let padrao: Bool
}
