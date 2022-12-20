//
//  ItemServicoView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 06/10/22.
//

import SwiftUI
import CoreData
import NavigationStack
import FormValidator

enum ItemServicoFocusable: Hashable
{
    case idservico
    case idcarro
    case km
    case data
    case nome
    case custo
    case observacoes
}

class ItemServicoFormInfo: ObservableObject
{
    @Published var idservico: UUID = UUID()
    @Published var idcarro: UUID = UUID()
    @Published var km: String = ""
    @Published var data: Date = Date()
    @Published var nome: String = ""
    @Published var custo: String = ""
    @Published var observacoes: String = ""
    
    let regexNumerico: String =  "[0-9[\\b]]+"
    
    lazy var form = { FormValidation(validationType: .deferred)}()
    lazy var valNomeVazio: ValidationContainer = { $nome.nonEmptyValidator(form: form, errorMessage: "nome deve ser informado")}()
    lazy var validacaoCusto: ValidationContainer = { $custo.nonEmptyValidator(form: form, errorMessage: "custo deve ser informado")}()
    lazy var valValorNumerico: ValidationContainer = { $custo.patternValidator(form: form, pattern: regexNumerico, errorMessage: "valor deve ser númerico")}()
}

struct ItemServicoView: View
{
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var formInfo = ItemServicoFormInfo()
    
    @StateObject private var viewModel = ItemServicoViewModel()
    @StateObject private var viewModelServico = ServicoViewModel()
    
    @FocusState private var itemServicoInFocus: ItemServicoFocusable?
    
    @State var isSaveDisabled: Bool = true
    @State var servico: Servico?
    
    let router = MyRouter.shared
    let pub = NotificationCenter.default.publisher(for: Notification.Name("Save"))

    var body: some View
    {
        NavigationView
        {
            VStack
            {
                HeaderSaveView(isSaveDisabled: $isSaveDisabled, nomeView: "Item serviço", nomeMenu: "Menu", destRouter: "lstItemServico")
                Form
                {
                    Section()
                    {
                        Picker("Serviço:", selection: $servico)
                        {
                            ForEach(viewModelServico.servicosLista) { (servico: Servico) in
                                Text(servico.nome!).tag(servico as Servico?)
                            }
                        }.pickerStyle(.automatic)
                            //.onAppear() { servico = pservico?.id}
                        TextField("km", text: $formInfo.km)
                            .keyboardType(.numbersAndPunctuation)
                            .focused($itemServicoInFocus, equals: .km)
                            .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {self.itemServicoInFocus = .km}}
                            .validation(formInfo.valValorNumerico)
                        DatePicker("data", selection: $formInfo.data)
                            .frame(maxHeight: 400)
                        TextField("nome", text: $formInfo.nome)
                            .validation(formInfo.valNomeVazio)
                        TextField("custo", text: $formInfo.custo)
                            .validation(formInfo.validacaoCusto)
                            .validation(formInfo.valValorNumerico)
                            .keyboardType(.numbersAndPunctuation)
                        TextField("observações", text: $formInfo.observacoes)
                    }
                }.onReceive(pub)  {_ in gravarItemServico()}
            }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
             .navigationBarTitle("")
             .navigationBarHidden(true)
        }
    }

    private func gravarItemServico()
    {
        let valid = formInfo.form.triggerValidation()
        if valid
        {
            let itemServico = NovoItemServico(id: UUID(),
                                                idcarro: formInfo.idcarro,
                                                km: (Int32(formInfo.km) ?? 0),
                                                data: formInfo.data,
                                                nome: formInfo.nome,
                                                custo: (Double(formInfo.custo) ?? 0),
                                                observacoes: formInfo.observacoes,
                                              doServico: servico!)
            viewModel.add(itemServico: itemServico)
        }
    }
}

