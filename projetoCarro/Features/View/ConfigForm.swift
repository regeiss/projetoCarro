//
//  ConfigForm.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 13/07/22.
//

import SwiftUI
import NavigationStack
import FormValidator

class ConfigInfo: ObservableObject
{
  @Published var firstName: String = ""
  lazy var form = { FormValidation(validationType: .immediate)}()
  lazy var firstNameValidation: ValidationContainer = {$firstName.nonEmptyValidator(form: form, errorMessage: "First name is not valid")}()
}

struct ConfigForm: View
{
    @ObservedObject var configInfo = ConfigInfo()
    @State private var unidadeVolume: String = ""
    @State private var backup: Bool = false
    @State private var alerta: Bool = false

    var body: some View
    {
        VStack {
        HeaderView()
        
        Form
        {
            // TODO: arrumar formatacao
            Section(header: Text("Configuração"),
                    footer: Text("c 2002"))
            {
                TextField("lts/gls", text: $unidadeVolume)

                TextField("First Name", text: $configInfo.firstName)
                    .validation(configInfo.firstNameValidation) // 6
                Toggle(isOn: $backup)
                {
                    Text("Backup")
                }
                Toggle(isOn: $alerta)
                {
                    Text("Alertas")
                }
                
            }
            Section
            {
                PopView
                {
                    Text("Ok").foregroundColor(.blue)
                }
            }
        }.padding()
        }}
}
