//
//  AbastecimentoForm.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI
import NavigationStack
import FormValidator

class AbastecimentoInfo: ObservableObject { @Published var firstName: String = ""

  lazy var form = { FormValidation(validationType: .immediate)}()
  lazy var firstNameValidation: ValidationContainer = { $firstName.nonEmptyValidator(form: form, errorMessage: "First name is not valid")}()
}

struct AbastecimentoView: View 
{
    let calendar = Calendar.current
    let date = Date()
    @ObservedObject var formInfo = AbastecimentoInfo()
    
    @State private var km: String = ""
    @State private var data: Date = Date()
    @State private var litros: String = "1"
    @State private var valorLitro: String = "1"
    @State private var completo: Bool = false
    @State private var isSaveDisabled: Bool = false
    private var tempValorLitro: String?
    
    private var valorTotal: String
       {
           let formatter = NumberFormatter()
           formatter.numberStyle = .currency
           
           let total = (Double(litros) ?? 0) * (Double(valorLitro) ?? 0)
           
           return formatter.string(from: NSNumber(value: total)) ?? "$0"
       }
    
    var body: some View 
    {
        VStack
        {
            HeaderView(nomeView: "Abastecimento", nomeMenu: "Menu")
            Form
            {
                // TODO: arrumar formatacao
                Section()
                {
                    TextField("km", text: $km)
                    DatePicker("Data", selection: $data)
                        .frame(maxHeight: 400)
                    TextField("litros", text: $litros)
                    TextField("valorLitro", text: $valorLitro)
                    Text("valorTotal \(valorTotal)")
                    TextField("First Name", text: $formInfo.firstName)
                        .validation(formInfo.firstNameValidation) // 6
                    Toggle(isOn: $completo)
                    {
                        Text("completo")
                    }
                }
                Section()
                {
                    PopView
                    {
                        Text("Ok").foregroundColor(.blue)
                    }
                }
            }.padding()
            Spacer()
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid }
    }
}


