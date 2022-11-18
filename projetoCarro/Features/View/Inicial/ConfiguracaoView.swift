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
