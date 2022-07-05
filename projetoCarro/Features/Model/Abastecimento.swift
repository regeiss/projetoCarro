//
//  Abastecimento.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import Foundation

struct Abastecimento: Decodable
{
    let id: UUID
    let km: Int
    let data: Date
    let litros: Double
    let valorLitro: Double
    let valorTotal: Decimal // Currency
    let total: Bool
}

extension Abastecimento
{
     static var dummyData: [Abastecimento]
     {
         [
            Abastecimento(id: UUID(), km: 137980, data: Date.now, litros:28.98, valorLitro: 7.00, valorTotal: 200.00, total: false),
            Abastecimento(id: UUID(), km: 137990, data: Date.now, litros:27.98, valorLitro: 6.90, valorTotal: 204.00, total: false)
         ]
     }
}

extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "pt_BR")
            return formatter
    }
}
//print(“GB”, NumberFormatter.currencyFormatter.string(from: correctResult as NSDecimalNumber)!) // GB £0.30
