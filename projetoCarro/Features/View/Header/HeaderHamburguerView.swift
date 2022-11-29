//
//  HeaderViewHamburguer.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 07/09/22.
//

import SwiftUI
import CoreData

@available(iOS 16.0, *)
struct HeaderHamburguerView: View
{
    @StateObject private var viewModelCarro = CarroViewModel()
    @Binding var showMenu: Bool
    @State private var isShowingSheet = false
    @State private var carroAtual: Carro?
    
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
                Text(carroAtual?.nome ?? "N/A")
                Spacer()
                Image(systemName: "car.2").foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.trailing])
                    .onTapGesture { isShowingSheet.toggle()}
            }
        }//.onReceive(NotificationCenter.default.publisher(
//            for: UIApplication.willEnterForegroundNotification
//            )) { _ in
//                loadViewData()
//            }
        .onAppear() { loadViewData()}
        .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss)
        {
            List
            {
                Section(header: Text("Selecione um carro")) {
                    ForEach(viewModelCarro.carrosLista, id: \.self) { carros in
                        ZStack()
                        {
                            HStack
                            {
                                HStack
                                {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .opacity(carros.ativo == true ? 100 : 0.0)
                                    Text(String(carros.nome ?? ""))
                                    Text(" "); Text(String(carros.placa ?? ""))
                                    Text(" "); Text(String(carros.ano))
                                }
                            }.onTapGesture() { marcarCarroComoAtivo(ativoID: carros.objectID)}
                            
                            Spacer()
                        }
                    }.presentationDetents([.medium, .large])
                }
                
            }
            Button("Dispensar", action: { isShowingSheet.toggle() })
                .buttonStyle(.borderedProminent)
                        .controlSize(.large)

        }
    }
    func loadViewData()
    {
        carroAtual = modeloGlobal.shared.carroAtual
    }
    
    func marcarCarroComoAtivo(ativoID: NSManagedObjectID)
    {
        viewModelCarro.marcarCarroAtivo(ativoID: ativoID)
        carroAtual = modeloGlobal.shared.carroAtual
    }
}
