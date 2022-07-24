//
//  AbastecimentoForm.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//
import SwiftUI
import NavigationStack
import FormValidator

class AbastecimentoInfo: ObservableObject
{
    @Published var km: String = ""
    @Published var data: Date = Date()
    @Published var litros: String = ""
    @Published var valorLitro: String = ""
    @Published var completo: Bool = false
    
    lazy var form = { FormValidation(validationType: .immediate)}()
    lazy var validacaoKm: ValidationContainer = { $km.nonEmptyValidator(form: form, errorMessage: "km deve ser informada")}()
    lazy var validacaoLitros: ValidationContainer = { $litros.nonEmptyValidator(form: form, errorMessage: "km deve ser informada")}()
    lazy var validacaoValorLitro: ValidationContainer = { $valorLitro.nonEmptyValidator(form: form, errorMessage: "km deve ser informada")}()
}

struct AbastecimentoView: View 
{
    @ObservedObject var formInfo = AbastecimentoInfo()
    @Environment(\.managedObjectContext) var moc
    
    @State private var km: String = ""
    @State private var data: Date = Date()
    @State private var litros: String = ""
    @State private var valorLitro: String = ""
    @State private var completo: Bool = false
    @State private var isSaveDisabled: Bool = false
    
    let date = Date()
    
    private var valorTotal: String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total = (Double(litros) ?? 0) * (Double(valorLitro) ?? 0)
        
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
                    TextField("km", text: $km).validation(formInfo.validacaoKm)
                    DatePicker("Data", selection: $data)
                        .frame(maxHeight: 400)
                    TextField("litros", text: $litros)
                    TextField("valorLitro", text: $valorLitro)
                    Text("valorTotal \(valorTotal)")
//                    TextField("First Name", text: $formInfo.firstName)
//                        .validation(formInfo.firstNameValidation) // 6
                    Toggle(isOn: $completo)
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
         .onDisappear {
                let newAbastecimento = Abastecimento(context: moc)
                newAbastecimento.id = UUID()
                newAbastecimento.km = Int32(km) ?? 0
                newAbastecimento.completo = Bool(completo)
                newAbastecimento.litros = Double(litros) ?? 0.0
                newAbastecimento.data = (data)
                newAbastecimento.valorLitro = Double(valorLitro) ?? 0.0
                newAbastecimento.valorTotal = (Double(litros) ?? 0) * (Double(valorLitro) ?? 0)
                print("printing valor total")
                print(valorTotal)
             try? moc.save()
            }
    }
}


