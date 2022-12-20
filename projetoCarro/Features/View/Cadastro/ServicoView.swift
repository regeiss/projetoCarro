//
//  Servicos.swift
//  projetoServico
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI
import CoreData
import NavigationStack
import FormValidator

enum ServicoFocusable: Hashable 
{
    case idcategoria
    case idperiodicidade 
    case nome
}

class ServicoFormInfo: ObservableObject
{
    @Published var nome: String = ""
    @Published var idcategoria: UUID = UUID()
    @Published var idperiodicidade: Int16 = 1

    let regexNumerico: String =  "[0-9[\\b]]+"
    
    lazy var form = { FormValidation(validationType: .deferred)}()
    lazy var valNomeVazio: ValidationContainer = { $nome.nonEmptyValidator(form: form, errorMessage: "nome deve ser informado")}()
}

@available(iOS 16.0, *)
struct ServicoView: View
{
    @StateObject private var viewModel = ServicoViewModel()
    @StateObject private var viewModelCategoria = CategoriaViewModel()
    
    @ObservedObject var formInfo = ServicoFormInfo()
    @State var isSaveDisabled: Bool = true
    @FocusState private var servicoInFocus: ServicoFocusable?
    
    @State var categoria: Categoria?
    var isEdit: Bool
    var servico: Servico
    
    let router = MyRouter.shared
    let pub = NotificationCenter.default.publisher(for: Notification.Name("Save"))

    var body: some View
    {
        VStack
        {
            HeaderSaveView(isSaveDisabled: $isSaveDisabled, nomeView: "Serviço", nomeMenu: "Menu", destRouter: "lstServico")
            Form
            {
                Section()
                {
                    TextField("nome", text: $formInfo.nome)
                        .validation(formInfo.valNomeVazio)
                        .focused($servicoInFocus, equals: .nome)
                        .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {self.servicoInFocus = .nome}}
                    
                    Picker("Categoria:", selection: $categoria)
                    {
                        ForEach(viewModelCategoria.categoriasLista) { (categoria: Categoria) in
                            Text(categoria.nome!).tag(categoria as Categoria?)
                        }
                    }.pickerStyle(.automatic)
                    Text(String(formInfo.idperiodicidade))
                }
            }.onReceive(pub)  {_ in gravarServico()}
             .onAppear() {if isEdit {formInfo.nome = servico.nome ?? ""}}
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
    }

    private func gravarServico()
    {
        let valid = formInfo.form.triggerValidation()
        if valid
        {
            if valid
            {
                if isEdit
                {
                    servico.nome = formInfo.nome
                    viewModel.update(servico: servico)
                }
                else
                {
                    let servico = NovoServico(id: UUID(),
                                              idperiodicidade: formInfo.idperiodicidade,
                                              nome: formInfo.nome,
                                              daCategoria: categoria!)
                    viewModel.add(servico: servico)
                }
            }
       }
    }
}

