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
    @State private var litros: String = "1"
    @State private var valorLitro: String = "1"
    @State private var completo: Bool = false
    @State private var isSaveDisabled: Bool = false
    
    private var valorTotal: String
       {
           let formatter = NumberFormatter()
           formatter.numberStyle = .currency
           
           let total = Double(litros)! * Double(valorLitro)!
           
           return formatter.string(from: NSNumber(value: total)) ?? "$0"
       }
    
    var body: some View 
    {
        VStack
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
            }
            
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid }
            .toolbar{ToolbarItem(placement: .navigationBarLeading) {
                Button("New"){} }}
    }
}


