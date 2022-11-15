//
//  RelServicoView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 19/10/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct RelServicoView: View
{
    @StateObject private var viewModel = ItemServicoViewModel()

    @State var textoFiltro: String = "Todos"
    private var consumoMedio: Double = 0
    let pub = NotificationCenter.default.publisher(for: Notification.Name("Filtro"))
    
    var body: some View
    {
        VStack()
        {
            HeaderFiltroView(nomeView: "Serviço", nomeMenu: "Relatórios", destRouter: "rel")
            List
            {
                // TODO: Ajustar o calculo do rodape
                Section(header: Text(textoFiltro), footer: Text("Total: " + String(viewModel.itemServicoLista.map{$0.custo}.reduce(0, +)).toCurrencyFormat()))
                {
                    ForEach(viewModel.itemServicoLista, id: \.self) { servico in
                        VStack
                        {
                            HStack
                            {
                                Text(String(servico.nome ?? ""))
                                Spacer()
                            }
                            HStack
                            {
                                Text((servico.data ?? Date()).formatted(date: .numeric, time: .omitted))
                                Spacer()
                                Text(String(servico.custo).toCurrencyFormat())
                            }
                        }
                    }
                }.headerProminence(.increased)
            }.onReceive(pub) { msg in
                if let info = msg.userInfo, let infoPeriodo = info["Periodo"] as? String
                {
                    ajustarHeader(info: infoPeriodo)
                }
            }
            
            Spacer()
        }
    }
    
    func ajustarHeader(info: String)
    {
        textoFiltro = info
        viewModel.filter(tipo: textoFiltro)
    }
}
