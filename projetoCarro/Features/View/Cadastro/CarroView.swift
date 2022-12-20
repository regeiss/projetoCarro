//
//  CarroView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 30/08/22.
//

import SwiftUI
import CoreData
import NavigationStack
import FormValidator

enum CarroFocusable: Hashable 
{
    case nome 
    case marca 
    case modelo
    case placa 
    case chassis 
    case ano 
}

class CarroFormInfo: ObservableObject
{
    @Published var nome: String = ""
    @Published var marca: String = ""
    @Published var modelo: String = ""
    @Published var placa: String = ""
    @Published var chassis: String = ""
    @Published var ano: String = ""
    
    let regexNumerico: String =  "[0-9[\\b]]+"
    
    lazy var form = { FormValidation(validationType: .deferred)}()
    lazy var valNomeVazio: ValidationContainer = { $nome.nonEmptyValidator(form: form, errorMessage: "nome deve ser informado")}()
}

@available(iOS 16.0, *)
struct CarroView: View
{
    @StateObject private var viewModel = CarroViewModel()

    @ObservedObject var formInfo = CarroFormInfo()
    @State var isSaveDisabled: Bool = true
    @FocusState private var carroInFocus: CarroFocusable?
    // controle do tipo de edição
    var isEdit: Bool
    var carro: Carro
    
    let router = MyRouter.shared
    let pub = NotificationCenter.default.publisher(for: Notification.Name("Save"))

    var body: some View
    {
        VStack
        {
            HeaderSaveView(isSaveDisabled: $isSaveDisabled, nomeView: "Veículos", nomeMenu: "Menu", destRouter: "lstCarro")
            Form
            {
                Section()
                {
                    TextField("nome", text: $formInfo.nome)
                        .validation(formInfo.valNomeVazio)
                        .focused($carroInFocus, equals: .nome)
                        .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {self.carroInFocus = .nome}}
                    TextField("marca", text: $formInfo.marca)
                    TextField("modelo", text: $formInfo.modelo)
                    TextField("placa", text: $formInfo.placa)
                    TextField("chassis", text: $formInfo.chassis)
                    TextField("ano", text: $formInfo.ano)
                }
            }.onReceive(pub)  {_ in gravarCarro()}
             .onAppear() { if isEdit {
                                      formInfo.nome = carro.nome ?? ""
                                      formInfo.marca = carro.marca ?? ""
                                      formInfo.modelo = carro.modelo ?? ""
                                      formInfo.placa = carro.placa ?? ""
                                      formInfo.chassis = carro.chassis ?? ""
                                      formInfo.ano = String(carro.ano)
             }}
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
    }

    private func gravarCarro()
    {
        let valid = formInfo.form.triggerValidation()
        if valid
        {
            if isEdit
            {
                carro.nome = formInfo.nome
                carro.marca = formInfo.marca
                carro.modelo = formInfo.modelo
                carro.placa = formInfo.placa
                carro.chassis = formInfo.chassis
                carro.ano = Int16(formInfo.ano) ?? 1990
                viewModel.update(carro: carro)
            }
            else
            {
                let carro = NovoCarro(id: UUID(),
                                      nome: formInfo.nome,
                                      marca: formInfo.marca,
                                      modelo: formInfo.modelo,
                                      placa: formInfo.placa,
                                      chassis: formInfo.chassis,
                                      padrao: false,
                                      ano: Int16(formInfo.ano) ?? 0)
                viewModel.add(carro: carro)
            }
        }
    }
}

