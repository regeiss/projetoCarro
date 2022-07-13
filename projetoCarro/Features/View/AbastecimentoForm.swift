//
//  AbastecimentoForm.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI
import NavigationStack
import FormValidator

// 2
class FormInfo: ObservableObject {
  @Published var firstName: String = ""
  // 3
  lazy var form = {
    FormValidation(validationType: .immediate)
  }()
  // 4
  lazy var firstNameValidation: ValidationContainer = {
    $firstName.nonEmptyValidator(form: form, errorMessage: "First name is not valid")
  }()
}

struct AbastecimentoForm: View 
{
    let calendar = Calendar.current
    let date = Date()
    @ObservedObject var formInfo = FormInfo()
    
    @State private var km: String = ""
    @State private var data: Date = Date()
    @State private var litros: String = ""
    @State private var valorLitro: String = ""
    @State private var valorTotal: String = ""
    @State private var completo: Bool = false

    var body: some View 
    {
        Form
        {
            // TODO: arrumar formatacao
            Section(header: Text("Abastecimento"),
                    footer: Text("Informe todos os dados"))
            {
                TextField("km", text: $km)
                DatePicker("Data", selection: $data)
                //.datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxHeight: 400)
                TextField("litros", text: $litros)
                TextField("valorLitro", text: $valorLitro)
                TextField("valorTotal", text: $valorTotal)
                TextField("First Name", text: $formInfo.firstName)
                    .validation(formInfo.firstNameValidation) // 6
                Toggle(isOn: $completo)
                {
                    Text("completo")
                }
                PopView {
                    Text("POP")
                }
            }
        }
    }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid }
}


