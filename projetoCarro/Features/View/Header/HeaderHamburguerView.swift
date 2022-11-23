//
//  HeaderViewHamburguer.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 07/09/22.
//

import SwiftUI

@available(iOS 16.0, *)
struct HeaderHamburguerView: View
{
    @StateObject private var viewModel = CarroViewModel()
    @Binding var showMenu: Bool
    @State private var isShowingSheet = false
    
    let router = MyRouter.shared
    var nomeView: String
    var nomeMenu: String
    
    func didDismiss()
    {
        // Handle the dismissing action.
    }
    
    var body: some View
    {
        VStack()
        {
            HStack
            {
                Image(systemName: "line.horizontal.3").foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.leading])
                    .onTapGesture { withAnimation { self.showMenu.toggle()}}
                
                Text(nomeMenu).foregroundColor(.blue).font(.system(.title3, design: .rounded))
                Spacer()
                Text(modeloGlobal.shared.carroAtual?.nome ?? "N/A")
                Spacer()
                Image(systemName: "car.2").foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.trailing])
                    .onTapGesture { isShowingSheet.toggle()}
            }
        }.sheet(isPresented: $isShowingSheet, onDismiss: didDismiss)
        {
            VStack
            {
                ForEach(viewModel.carrosLista, id: \.self) { carros in
                    ZStack()
                    {
                        Color(.systemGray6)
                        HStack
                        {
                            Label("car", systemImage: "car").labelStyle(.iconOnly)
                            VStack
                            {
                                HStack
                                {
                                    Text("Nome: "); Text(String(carros.nome ?? ""))
                                    Text(" "); Text(String(carros.placa ?? ""))
                                    Text(" "); Text(String(carros.ano))
                                    Spacer()
                                }
                            }
                        }
                    }
                }.presentationDetents([.medium, .large])
            }
            Button("Dispensar", action: { isShowingSheet.toggle() })
        }
    }
    
}
