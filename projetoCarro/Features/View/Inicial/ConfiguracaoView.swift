//
//  ConfigForm.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 13/07/22.
//

import SwiftUI
import NavigationStack
import FormValidator

@available(iOS 16.0, *)
struct ConfiguracaoView: View
{
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    
    init()
    {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
    }
    
    @ObservedObject var userSettings = UserSettings()

    let router = MyRouter.shared
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HeaderView(nomeView: "Configuração", nomeMenu: "Menu")
            
            Form
            {
                Section()
                {
                    Picker(selection: $userSettings.unidadeVolume, label: Text("unidadeVolume")) 
                    {
                        ForEach(userSettings.unidadesVolume, id: \.self) { unidadeVolume in
                            Text(unidadeVolume)
                        }
                    }.pickerStyle(SegmentedPickerStyle())

                    Toggle(isOn: $userSettings.backup)
                    {
                        Text("Backup")
                    }
                    Toggle(isOn: $userSettings.alertas)
                    {
                        Text("Alertas")
                    }
                    Toggle(isOn: $userSettings.modoEscuro)
                    {
                        Text("Modo escuro")
                    }
                }
                Section()
                {
                Button(action: {
                                needsAppOnboarding = true
                            }) {
                                Text("Reset Onboarding")
                                .padding(.horizontal, 40)
                                .padding(.vertical, 15)
                                .font(Font.title2.bold().lowercaseSmallCaps())
                            }
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(40)
            
                    Button("OK")
                    {
                        router.toMenu()
                    }
                }
            }
            Spacer()
        }
        
    }
}
