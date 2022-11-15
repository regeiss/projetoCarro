//
//  Abastecimento.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import Foundation
  
struct ultimoAbastecimento: Identifiable
{
    let id: UUID
    let km: Int32
    let data: Date
    let litros: Double
    let valorLitro: Double
    let valorTotal: Decimal // Currency
    let completo: Bool
    let media: Double
    let doPosto: Posto
    let doCarro: Carro
}
