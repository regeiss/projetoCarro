//
//  RelConsumoView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 18/10/22.
//

import SwiftUI 

struct RelConsumoView: View
{
    private var consumoMedio: Double = 0
    private var piorConsumo: Double = 0
    private var melhorConsumo: Double = 0
    private var distanciaTotal: Double = 0
    
    var body: some View
    {
        VStack()
        {
            HeaderRelatorioView(nomeView: "Consumo", nomeMenu: "Relatórios", destRouter: "rel")
            VStack()
            {
                HStack()
                {
                    Text("Consumo médio")
                    Spacer()
                    Text(String(consumoMedio))
                }
                HStack()
                {
                    Text("Pior consumo ")
                    Spacer()
                    Text(String(consumoMedio))
                }
                HStack()
                {
                    Text("Melhor consumo ")
                    Spacer()
                    Text(String(consumoMedio))
                }
                HStack()
                {
                    Text("Distância total ")
                    Spacer()
                    Text(String(consumoMedio))
                }
            }.padding([.leading, .trailing], 45)
        }
    }
}

