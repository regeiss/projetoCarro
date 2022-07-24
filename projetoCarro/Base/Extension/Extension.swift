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

extension DateFormatter
{
    static var shortDateFormatter: DateFormatter
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }
}

extension Abastecimento
{
    static var currencyFormatter: NumberFormatter
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt-BR")
        return formatter
    }
    
    static var decimalFormater: NumberFormatter
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        formatter.minimumIntegerDigits = 2
        return formatter
    }
}
