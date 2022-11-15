//
//  AbastecimentoListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 20/07/22.
//
import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct AbastecimentoListaView: View
{
    @StateObject private var viewModel = AbastecimentoViewModel()
    
    var body: some View
    {
        VStack
        {
            HeaderAddView(nomeView: "Lista abastecimento", nomeMenu: "Menu", destRouter: "abast", backRouter: "cadastros")
            List
            {
                ForEach(viewModel.abastecimentosLista, id: \.self) { abastecimento in
                    HStack
                    {
                        Label("gas", systemImage: "fuelpump.circle")
                            .labelStyle(.iconOnly)
                            .imageScale(.large)
                        VStack
                        {
                            HStack{Text("Data: "); Text((abastecimento.data ?? Date()).formatted(date: .numeric, time: .omitted))
                                Spacer();
                                if abastecimento.media > 0 {
                                    Text(String(format: "%.3f", abastecimento.media)); Text(" km/l")}}
                            HStack{Text("Total: ");Text (String(format: "%.2f", abastecimento.valorTotal).toCurrencyFormat()); Spacer()}
                            HStack{Text("Odômetro: "); Text(String(abastecimento.km).toQuilometrosFormat())
                                Spacer(); Text("Litros: "); Text(String(format: "%.3f", abastecimento.litros))}
                            HStack{Text(abastecimento.nomePosto); Spacer()}
                            HStack{Text(abastecimento.nomeCarro); Spacer()}
                        }.padding(.all, 2)
                    }.padding([.top, .bottom], 2)
                }.onDelete(perform: deleteAbastecimentos)
            }
            Spacer()
        }
    }

    func deleteAbastecimentos(at offsets: IndexSet)
    {
        for offset in offsets
        {
            let abastecimento = viewModel.abastecimentosLista[offset]
            viewModel.delete(abastecimento: abastecimento)
        }
    }
}

extension Abastecimento
{
    @objc
    var nomePosto: String
    {
        self.doPosto?.nome ?? "não informado"
    }
    
    @objc
    var nomeCarro: String
    {
        self.doCarro?.nome ?? "não informado"
    }
    
}
