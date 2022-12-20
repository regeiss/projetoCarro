//
//  PostoView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 30/08/22.
//

import SwiftUI
import CoreData
import NavigationStack
import FormValidator

enum PostoFocusable: Hashable
{
  case nome
  case logo
}

class PostoFormInfo: ObservableObject
{
    @Published var nome: String = ""
    
    lazy var form = { FormValidation(validationType: .deferred)}()
    lazy var valNomeVazio: ValidationContainer = { $nome.nonEmptyValidator(form: form, errorMessage: "nome deve ser informado")}()
}

@available(iOS 16.0, *)
struct PostoView: View
{
    @StateObject private var viewModel = PostoViewModel()
    @ObservedObject var formInfo = PostoFormInfo()
    @FocusState private var postoInFocus: PostoFocusable?
    @State var isSaveDisabled: Bool = true
    
    // controle do tipo de edição
    var isEdit: Bool
    var posto: Posto
    
    let router = MyRouter.shared
    let imgShell: UIImage = UIImage(named: "ipiranga")!
    
    let pub = NotificationCenter.default.publisher(for: Notification.Name("Save"))
    
    var body: some View
    {
        VStack
        {
            HeaderSaveView(isSaveDisabled: $isSaveDisabled, nomeView: "Posto", nomeMenu: "Menu", destRouter: "lstPosto")
            
            Form
            {
                Section()
                {
                    TextField("nome", text: $formInfo.nome)
                        .validation(formInfo.valNomeVazio)
                        .focused($postoInFocus, equals: .nome)
                        .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {self.postoInFocus = .nome}}
                }
                
            }.onReceive(pub)  {_ in gravarPosto()}
                .onAppear() {if isEdit {formInfo.nome = posto.nome ?? ""}}
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
    }
    
    private func gravarPosto()
    {
        let valid = formInfo.form.triggerValidation()
        if valid
        {
            if isEdit
            {
                posto.nome = formInfo.nome
                viewModel.update(posto: posto)
            }
            else
            {
                let logo = imgShell.toData as NSData?
                let nvp = NovoPosto(id: UUID(), nome: formInfo.nome, logo: logo!)
                viewModel.add(posto: nvp)
            }
        }
    }
}







//===================================================================================================================================================
//import SwiftUI
//import Combine
//
//struct ItemsView: View {
//    let items: [String]
//
//    @State private var keyboardHeight: CGFloat = 0
//    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
//        Publishers.Merge(
//            NotificationCenter.default
//                .publisher(for: UIResponder.keyboardWillShowNotification)
//                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
//                .map { $0.height },
//            NotificationCenter.default
//                .publisher(for: UIResponder.keyboardWillHideNotification)
//                .map { _ in CGFloat(0) }
//        ).eraseToAnyPublisher()
//    }
//
//    var body: some View {
//        List(items, id: \.self) { item in
//            Text(item)
//        }
//        .padding(.bottom, keyboardHeight)
//        .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
//    }
//}
