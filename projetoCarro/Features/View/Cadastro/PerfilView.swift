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
}

class PerfilFormInfo: ObservableObject
{
    @Published var nome: String = ""
    @Published var email: String = ""
    
    let regexNumerico: String =  "[0-9[\\b]]+"
    
    lazy var form = { FormValidation(validationType: .deferred)}()
    lazy var valNomeVazio: ValidationContainer = { $nome.nonEmptyValidator(form: form, errorMessage: "nome deve ser informado")}()
}

@available(iOS 16.0, *)
struct PerfilView: View
{
    @ObservedObject var formInfo = PerfilFormInfo()
   // @ObservedObject var salvarPerfil = SalvarPerfil()
    @StateObject private var viewModel = PerfilViewModel()

    @State private var isSaveDisabled: Bool = true
    @FocusState private var perfilInFocus: PerfilFocusable?
    
    let router = MyRouter.shared

    var body: some View
    {
        VStack
        {
            HeaderSaveView(isSaveDisabled: $isSaveDisabled, nomeView: "Perfil", nomeMenu: "Menu", destRouter: "default")
            Form
            {
                Section()
                {
                    TextField("nome", text: $formInfo.nome)
                        .validation(formInfo.valNomeVazio)
                        .focused($perfilInFocus, equals: .nome)
                        .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {self.perfilInFocus = .nome}}
                    TextField("email", text: $formInfo.email)
                        .keyboardType(.emailAddress)

                }
                
                Section()
                {
                    Button("OK")
                    {
                        let valid = formInfo.form.triggerValidation()
                        if valid
                        {
                            let perfil = NovoPerfil(id: UUID(),
                                                  nome: formInfo.nome,
                                                    email: formInfo.email,
                                                    padrao: false)

                            viewModel.add(perfil: perfil)
                            router.toMenu()
                        }
                    }.disabled(isSaveDisabled)
                }
            }//.onReceive(salvarPerfil.$salvar)
            
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
    }
}

