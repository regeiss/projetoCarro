//
//  Abastecimento.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import Foundation

struct ultimoAbastecimento: Decodable, Identifiable
{
    let id: UUID
    let km: Int
    let data: Date
    let litros: Double
    let valorLitro: Double
    let valorTotal: Decimal // Currency
    let completo: Bool
}
