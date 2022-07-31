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

class FormInfo: ObservableObject
{
    @Published var km: String = ""
    @Published var data: Date = Date()
    @Published var litros: String = ""
    @Published var valorLitro: String = ""
    @Published var completo: Bool = false
    @Published var firstName: String = ""
    
    lazy var form = { FormValidation(validationType: .immediate)}()
    lazy var validacaoKm: ValidationContainer = { $km.nonEmptyValidator(form: form, errorMessage: "km deve ser informada")}()
    lazy var validacaoLitros: ValidationContainer = { $litros.nonEmptyValidator(form: form, errorMessage: "km deve ser informada")}()
    lazy var validacaoValorLitro: ValidationContainer = { $valorLitro.nonEmptyValidator(form: form, errorMessage: "km deve ser informada")}()
    lazy var firstNameValidation: ValidationContainer = { $firstName.nonEmptyValidator(form: form, errorMessage: "First name is not valid")}()
}

struct AbastecimentoView: View 
{
    @Environment(\.managedObjectContext) var moc1
    @ObservedObject var formInfo = FormInfo()
    @State private var isSaveDisabled: Bool = false
    @FocusState private var nameInFocus: Bool
    
    private var valorTotal: String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total = (Double(formInfo.litros) ?? 0) * (Double(formInfo.valorLitro) ?? 0)
        
        return formatter.string(from: NSNumber(value: total)) ?? "$0"
    }
    
    var body: some View 
    {
        VStack
        {
            HeaderView(nomeView: "Abastecimento", nomeMenu: "Menu")
            Form
            {
                Section()
                {
                    TextField("km", text: $formInfo.km)
                        .validation(formInfo.validacaoKm)
                        .focused($nameInFocus)
                        .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {self.nameInFocus = true}}
                    TextField("First Name", text: $formInfo.firstName).validation(formInfo.firstNameValidation) // 6
                    DatePicker("Data", selection: $formInfo.data)
                        .frame(maxHeight: 400)
                    TextField("litros", text: $formInfo.litros)
                    TextField("valorLitro", text: $formInfo.valorLitro)
                    Text("valorTotal \(valorTotal)")
                    Toggle(isOn: $formInfo.completo)
                    {
                        Text("completo")
                    }
                }
                Section()
                {
                    PopView
                    {
                        Text("Ok").foregroundColor(.blue)
                    }
                }
            }.padding()
            Spacer()
            
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
            .onDisappear { moc1.perform {
                let newAbastecimento = Abastecimento(context: moc1)
                newAbastecimento.id = UUID()
                newAbastecimento.km = Int32(formInfo.km) ?? 45
             newAbastecimento.completo = Bool(formInfo.completo)
             newAbastecimento.litros = Double(formInfo.litros) ?? 23.0
             newAbastecimento.data = (formInfo.data)
             newAbastecimento.valorLitro = Double(formInfo.valorLitro) ?? 7.0
             newAbastecimento.valorTotal = (Double(formInfo.litros) ?? 0) * (Double(formInfo.valorLitro) ?? 0)

             try? moc1.save()
             print("Registro incluido")
            }
            }
                
    }
}


