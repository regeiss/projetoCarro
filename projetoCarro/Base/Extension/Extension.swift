//
//  Extension.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 05/07/22.
//

import Foundation

extension NumberFormatter 
{
    static var currencyFormatter: NumberFormatter 
    {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "pt-BR")
            return formatter
    }
}
