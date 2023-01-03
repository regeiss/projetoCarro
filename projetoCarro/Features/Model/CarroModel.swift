//
//  CarroModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 01/09/22.
//

import Foundation

struct NovoCarro: Identifiable
{
    let id: UUID
    let nome: String
    let marca: String
    let modelo: String
    let placa: String
    let chassis: String
    let ativo: Bool
    let ano: Int16
}
