//
//  ServicoModel.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 27/09/22.
//

import Foundation

struct NovoServico: Identifiable
{
    let id: UUID
    let idperiodicidade: Int16
    let nome: String
    let daCategoria: Categoria
}

struct NovoItemServico: Identifiable
{
    let id: UUID
    let idcarro: UUID
    let km: Int32
    let data: Date
    let nome: String
    let custo: Double
    let observacoes: String
    let doServico: Servico
}
