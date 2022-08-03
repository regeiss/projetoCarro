//
//  UltimoAbastecimentoView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 02/08/22.
//

import CoreData
import NavigationStack
import SwiftUI

struct UltimoAbastecimentoView: View
{
    var abastecimentos: Abastecimento

    var body: some View
    {
        VStack(alignment: .leading, spacing: 10)
        {
            HStack
            {
                Text("Última vez: ")
                Text((abastecimentos.data ?? Date()).formatted(date: .abbreviated, time: .shortened))
                    .font(.body)
                    .foregroundColor(.black)
            }

            HStack
            {
                Text("Odômetro: ")
                Text(String(abastecimentos.km))
                    .font(.body)
                    .foregroundColor(.black)
            }

            HStack
            {
                Text("Volume: ")
                Text(String(format: "%.2f", abastecimentos.litros))
                    .font(.body)
                    .foregroundColor(.black)
            }

            HStack
            {
                Text("Valor: ")
                Text(String(format: "%.2f", abastecimentos.valorTotal))
                    .font(.body)
                    .foregroundColor(.black)
            }
        }.padding()
    }
}
