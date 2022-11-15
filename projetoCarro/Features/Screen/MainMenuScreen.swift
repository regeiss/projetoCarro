//
//  MenuScreen.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import CoreData
import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct MainMenuScreen: View
{
    @Binding var showMenu: Bool
    @State private var selection: String = ""
    
    let router = MyRouter.shared
    
    var body: some View
    {
        let collections = [
            Collections(id: 0, name: "Abastecimento", image: "gasStation", content: "."),
            Collections(id: 1, name: "Serviço", image: "service", content: "."),
            Collections(id: 2, name: "Relatórios", image: "report", content: "."),
            Collections(id: 3, name: "Alertas", image: "alertas", content: "."),
            Collections(id: 4, name: "Cadastros", image: "config", content: ".")
        ]

        let drag = DragGesture()
            .onEnded
        {
            if $0.translation.width < -100
            {
                withAnimation{ self.showMenu = false}
            }
        }
        
        let columns = [ GridItem(.flexible(minimum: 230, maximum: .infinity))]
        
        VStack()
        {
            HeaderHamburguerView(showMenu: $showMenu, nomeView: "Inicial", nomeMenu: " ")
            HStack
            {
                Text("Projeto Carro")
                    .font(.system(.largeTitle, design: .rounded, weight: .heavy))
                    .padding([.leading])
            }
            
            ScrollView(.vertical)
            {
                LazyVGrid(columns: columns, alignment: .center, spacing: 5)
                {
                    ImageLabelRow(collection: collections[0])
                    ImageLabelRow(collection: collections[1])
                    ImageLabelRow(collection: collections[2])
                    ImageLabelRow(collection: collections[3])
                    ImageLabelRow(collection: collections[4])

                }.padding([.leading, .trailing])
                 .gesture(drag)
            }
        }
    }
}

