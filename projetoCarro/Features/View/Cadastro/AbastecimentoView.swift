//
//  AbastecimentoForm.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//
import SwiftUI
import CoreData
import NavigationStack
import FormValidator
import ErrorHandler

enum AbastecimentoFocusable: Hashable 
{
    case km
    case data
    case litros
    case valorLitro
    case completo
}

class AbastecimentoFormInfo: ObservableObject
{
    @Published var km: String = ""
    @Published var data: Date = Date()
    @Published var litros: String = ""
    @Published var valorLitro: String = ""
    @Published var completo: Bool = false
    
    let regexNumerico: String =  "[0-9[\\b]]+"
    
    lazy var form = { FormValidation(validationType: .immediate)}()
    lazy var valKMVazio: ValidationContainer = { $km.nonEmptyValidator(form: form, errorMessage: "km deve ser informada")}()
    lazy var valKMNumerico: ValidationContainer = { $km.patternValidator(form: form, pattern: regexNumerico, errorMessage: "km deve ser númerica")}()
    lazy var valLitros: ValidationContainer = { $litros.nonEmptyValidator(form: form, errorMessage: "qtd litros deve ser informada")}()
    lazy var valLitrosNumerico: ValidationContainer = { $litros.patternValidator(form: form, pattern: regexNumerico, errorMessage: "qtd litros deve ser númerica")}()
    lazy var validacaoValorLitro: ValidationContainer = { $valorLitro.nonEmptyValidator(form: form, errorMessage: "valor deve ser informado")}()
    lazy var valValorNumerico: ValidationContainer = { $valorLitro.patternValidator(form: form, pattern: regexNumerico, errorMessage: "valor litro deve ser númerico")}()
    lazy var dataAbastecimento: ValidationContainer = { $data.dateValidator(form: form, before: Date(), errorMessage: "data não pode maior que hoje")}()
}

@available(iOS 16.0, *)
struct AbastecimentoView: View
{
    @StateObject private var viewModel = AbastecimentoViewModel()
    @StateObject private var viewModelPosto = PostoViewModel()
    @StateObject private var viewModelCarro = CarroViewModel()
    
    @ObservedObject var formInfo = AbastecimentoFormInfo()
    @State var isSaveDisabled: Bool = true
    @FocusState private var abastecimentoInFocus: AbastecimentoFocusable?
    @State var posto: Posto?
    @EnvironmentObject var errorHandling: ErrorHandling
    
    let router = MyRouter.shared
    let pub = NotificationCenter.default.publisher(for: Notification.Name("Save"))

    private var valorTotal: String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total = (Double(formInfo.litros) ?? 0) * (Double(formInfo.valorLitro) ?? 0)
        
        return formatter.string(from: NSNumber(value: total)) ?? "$0"
    }   
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                HeaderSaveView(isSaveDisabled: $isSaveDisabled, nomeView: "Posto", nomeMenu: "Menu", destRouter: "lstAbastecimento")
                Form
                {
                    Section()
                    {
                        TextField("km", text: $formInfo.km)
                            .validation(formInfo.valKMVazio)
                            .validation(formInfo.valKMNumerico)
                            .focused($abastecimentoInFocus, equals: .km)
                            .keyboardType(.numbersAndPunctuation)
                            .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {self.abastecimentoInFocus = .km}}
                        DatePicker("Data", selection: $formInfo.data)
                            .frame(maxHeight: 400)
                            .focused($abastecimentoInFocus, equals: .data)
                            .validation(formInfo.dataAbastecimento)
                        TextField("litros", text: $formInfo.litros)
                            .validation(formInfo.valLitros)
                            .validation(formInfo.valLitrosNumerico)
                            .focused($abastecimentoInFocus, equals: .litros)
                            .keyboardType(.numbersAndPunctuation)
                        TextField("valorLitro", text: $formInfo.valorLitro)
                            .validation(formInfo.validacaoValorLitro)
                            .validation(formInfo.valValorNumerico)
                            .focused($abastecimentoInFocus, equals: .litros)
                            .keyboardType(.numbersAndPunctuation)
                        Text("Valor total \(valorTotal)")
                        Toggle(isOn: $formInfo.completo)
                        {
                            Text("completo")
                        }.focused($abastecimentoInFocus, equals: .completo)
                        
                        Picker("Posto:", selection: $posto)
                        {
                            ForEach(viewModelPosto.postosLista) { (posto: Posto) in
                                Text(posto.nome!).tag(posto as Posto?)
                            }
                        }.pickerStyle(.automatic)
                    }
                }
                .onReceive(pub)  {_ in gravarAbastecimento()}
            }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    fileprivate func extractedFunc() throws
    {
        guard let postoPicker = posto
        else
        {
            //let postoPicker = viewModelPosto.postosLista.first
            throw ValidationError.missingName
        }
        let uab = ultimoAbastecimento(id: UUID(),
                                          km: (Int32(formInfo.km) ?? 0),
                                          data: formInfo.data,
                                          litros: (Double(formInfo.litros) ?? 0),
                                          valorLitro: (Double(formInfo.valorLitro) ?? 0),
                                          valorTotal: (Decimal((Double(formInfo.litros) ?? 0) * (Double(formInfo.valorLitro) ?? 0))),
                                          completo:  Bool(formInfo.completo),
                                          media: calculaMedia(kmAtual: Int32(formInfo.km) ?? 0, litros: Double(formInfo.litros) ?? 0),
                                          doPosto: postoPicker,
                                          doCarro: modeloGlobal.shared.carroAtual!)
        
            viewModel.add(abastecimento: uab)
    }
    
    private func gravarAbastecimento()
    {
        let valid = formInfo.form.triggerValidation()
        if valid
        {
            do
            {
                try extractedFunc()
            }

            catch
            {
                self.errorHandling.handle(error: error)
            }
        }
    }

    private func calculaMedia(kmAtual: Int32, litros: Double) -> Double
    {
        var media: Double
        var kmPercorrida: Int32
        
        if viewModel.abastecimentosLista.count == 0
        {
            return 0
        }
        else
        {
            kmPercorrida = kmAtual - modeloGlobal.shared.ultimaKM
            media = Double(kmPercorrida) / (Double(formInfo.litros) ?? 0)
            return media
        }
    }
}

