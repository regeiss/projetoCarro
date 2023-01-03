//
//  PerfilView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 21/09/22.
//

import SwiftUI
import CoreData
import NavigationStack
import FormValidator

enum PerfilFocusable: Hashable
{
    case nome
    case email
    case ativo
}

class PerfilFormInfo: ObservableObject
{
    @Published var nome: String = ""
    @Published var email: String = ""
    @Published var ativo: Bool = false
    
    let regexNumerico: String =  "[0-9[\\b]]+"
    
    lazy var form = { FormValidation(validationType: .deferred)}()
    lazy var valNomeVazio: ValidationContainer = { $nome.nonEmptyValidator(form: form, errorMessage: "nome deve ser informado")}()
}

@available(iOS 16.0, *)
struct PerfilView: View
{
    @ObservedObject var formInfo = PerfilFormInfo()
    @StateObject private var viewModel = PerfilViewModel()
    @FocusState private var perfilInFocus: PerfilFocusable?
    @State private var isSaveDisabled: Bool = true
    
    // controle do tipo de edição
    var isEdit: Bool
    var perfil: Perfil
    
    let router = MyRouter.shared
    let pub = NotificationCenter.default.publisher(for: Notification.Name("Save"))
    
    var body: some View
    {
        VStack
        {
            HeaderSaveView(isSaveDisabled: $isSaveDisabled, nomeView: "Perfil", nomeMenu: "Menu", destRouter: "lstPerfil")
            Form
            {
                Section()
                {
                    TextField("nome", text: $formInfo.nome)
                        .validation(formInfo.valNomeVazio)
                        .focused($perfilInFocus, equals: .nome)
                        .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) { self.perfilInFocus = .nome }}
                    TextField("email", text: $formInfo.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        .textCase(.lowercase)
                    Toggle(isOn: $formInfo.ativo)
                    {
                        Text("Padrão")
                    }
                }
            }.onReceive(pub)  {_ in gravarPerfil() }
            .onAppear() { if isEdit {
                            formInfo.nome = perfil.nome ?? ""
                            formInfo.email = perfil.email ?? ""
                            formInfo.ativo = perfil.ativo
                        }}
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
    }
    
    private func gravarPerfil()
    {
        let valid = formInfo.form.triggerValidation()
        if valid
        {
            if isEdit
            {
                perfil.nome = formInfo.nome
                perfil.email = formInfo.email
                perfil.ativo = formInfo.ativo
                viewModel.update(perfil: perfil)
            }
            else
            {
                let nvp = NovoPerfil(id: UUID(), nome: formInfo.nome, email: formInfo.email, ativo: false)
                viewModel.add(perfil: nvp)
            }
        }
    }
}
