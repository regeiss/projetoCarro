//
//  AbastecimentoForm.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI

struct AbastecimentoForm: View {
    let calendar = Calendar.current
let date = Date()
    var body: some View {
        NavigationView
        {
            Form
            {
                // TODO: arrumar formatacao
                Section(header: Text("Display"),
                        footer: Text("System settings will override Dark Mode and use the current device theme")) {
//                    Toggle(isOn: $darkModeEnabled,
//                           label: {
//                            Text("Dark mode")
//                           })
//                        .onChange(of: darkModeEnabled,
//                                  perform: { _ in
//                                    themeManager.handleTheme(darkMode: darkModeEnabled,
//                                                                  system: systemThemeEnabled)
//
//                                  })
//                    Toggle(isOn: $systemThemeEnabled,
//                           label: {
//                            Text("Use system settings")
//                           })
//                        .onChange(of: systemThemeEnabled,
//                                  perform: { _ in
//                                    themeManager.handleTheme(darkMode: darkModeEnabled,
//                                                                  system: systemThemeEnabled)
//
//                                  })
//                }
//
//                Section {
//                    Link(destination: URL(string: Constants.twitter)!,
//                         label: {
//                            Label("Follow me on Twitter @tundsdev", systemImage: "link")
//                    })
//
//                    Link("Contact me via email",
//                         destination: URL(string: Constants.email)!)
//
//                    Link("Call me",
//                         destination: URL(string: Constants.phone)!)
                }
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .semibold))
            }
            .navigationTitle("Settings")
        }
    }
}

struct AbastecimentoForm_Previews: PreviewProvider {
    static var previews: some View {
        AbastecimentoForm()
    }
}
