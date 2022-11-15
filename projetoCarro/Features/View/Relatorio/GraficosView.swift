//
//  Graficos.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 06/10/22.
//

import SwiftUI
import Charts
import NavigationStack

//struct GraficosView: View
//{
//    var body: some View
//    {
//        VStack
//        {
//            HeaderView(nomeView: "Gráficos", nomeMenu: "Menu")
//
//            List
//            {
//                Chart
//                {
//                    BarMark(
//                        x: .value("Mount", "jan/22"),
//                        y: .value("Value", 5)
//                    )
//                    BarMark(
//                        x: .value("Mount", "fev/22"),
//                        y: .value("Value", 4)
//                    )
//                    BarMark(
//                        x: .value("Mount", "mar/22"),
//                        y: .value("Value", 7)
//                    )
//                }
//                .frame(height: 250)
//            }
//        }
//    }
//}

struct MountPrice: Identifiable {
    var id = UUID()
    var mount: String
    var value: Double
    var type: String
}

struct GraficosView: View {
    let data: [MountPrice] = [
        MountPrice(mount: "jan/22", value: 5, type: "A"),
        MountPrice(mount: "feb/22", value: 4, type: "A"),
        MountPrice(mount: "mar/22", value: 7, type: "A"),
        MountPrice(mount: "apr/22", value: 15, type: "A"),
        MountPrice(mount: "may/22", value: 14, type: "A"),
        MountPrice(mount: "jun/22", value: 27, type: "A"),
        MountPrice(mount: "jul/22", value: 27, type: "A"),
        
        MountPrice(mount: "jan/22", value: 15, type: "B"),
        MountPrice(mount: "feb/22", value: 14, type: "B"),
        MountPrice(mount: "mar/22", value: 17, type: "B"),
        MountPrice(mount: "apr/22", value: 25, type: "B"),
        MountPrice(mount: "may/22", value: 24, type: "B"),
        MountPrice(mount: "jun/22", value: 37, type: "B"),
        MountPrice(mount: "jul/22", value: 49, type: "B")
    ]
        
    var body: some View
    {
        VStack
        {
            HeaderRelatorioView(nomeView: "Gráficos", nomeMenu: "Relatórios", destRouter: "rel")
            List {
                Chart {
                    ForEach(data) {
                        AreaMark(
                            x: .value("Mount", $0.mount),
                            y: .value("Value", $0.value)
                        )
                        .foregroundStyle(by: .value("Type", "Series \($0.type)"))
                    }
                }
                .frame(height: 250)
            }
        }
    }
}
