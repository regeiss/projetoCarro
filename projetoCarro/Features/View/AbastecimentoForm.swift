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

            Form
            {
                // TODO: arrumar formatacao
                Section(header: Text("Display"),
                        footer: Text("System settings will override Dark Mode and use the current device theme")) {

                }
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .semibold))
            }
            .navigationTitle("Settings")
        
    }
}

struct AbastecimentoForm_Previews: PreviewProvider {
    static var previews: some View {
        AbastecimentoForm()
    }
}

//////
//struct ContentView: View {
//    @State var username: String = ""
//    @State var isPrivate: Bool = true
//    @State var notificationsEnabled: Bool = false
//    @State private var previewIndex = 0
//    var previewOptions = ["Always", "When Unlocked", "Never”]
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("PROFILE")) {
//                    TextField("Username", text: $username)
//                    Toggle(isOn: $isPrivate) {
//                        Text("Private Account")
//                    }
//                }
//                
//                Section(header: Text("NOTIFICATIONS")) {
//                    Toggle(isOn: $notificationsEnabled) {
//                        Text("Enabled")
//                    }
//                    Picker(selection: $previewIndex, label: Text("Show Previews")) {
//                        ForEach(0 ..< previewOptions.count) {
//                            Text(self.previewOptions[$0])
//                        }
//                    }
//                }
//                
//                Section(header: Text("ABOUT")) {
//                    HStack {
//                        Text("Version")
//                        Spacer()
//                        Text("2.2.1")
//                    }
//                }
//                
//                Section {
//                    Button(action: {
//                        print("Perform an action here...")
//                    }) {
//                        Text("Reset All Settings")
//                    }
//                }
//            }
//            .navigationBarTitle("Settings")
//        }
//    }
//}
