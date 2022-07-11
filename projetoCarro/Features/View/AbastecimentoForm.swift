//
//  AbastecimentoForm.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI

struct AbastecimentoForm: View 
{
    let calendar = Calendar.current
    let date = Date()

    @State var km: Int
    @State var data: Date
    @State var litros: Double
    @State var valorLitro: Double
    @State var valorTotal: Decimal 
    @State var completo: Bool

    var body: some View 
    {
        {
            Form
            {
                // TODO: arrumar formatacao
                Section(header: Text("Abastecimento"),
                        footer: Text("Informe todos os dados")) 
                {
                    TextField("km", text: $km)
                     DatePicker("Data", selection: $data)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .frame(maxHeight: 400)
                    TextField("litros", text: $litros)
                    TextField("valorLitro", text: $valorLitro)
                    TextField("valorTotal", text: $valorTotal)
                    Toggle(isOn: $completo) 
                    {
                        Text("completo")
                    }
                }

            }
        }
    }
}


