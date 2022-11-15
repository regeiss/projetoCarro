//
//  HeaderSaveView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 11/10/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct HeaderSaveView: View
{
    @Binding var isSaveDisabled: Bool
    let router = MyRouter.shared
    var nomeView: String
    var nomeMenu: String
    var destRouter: String
    //
    let savePublisher = NotificationCenter.default.publisher(for: NSNotification.Name("Save"))
    
    var body: some View
    {
        VStack()
        {
            HStack
            {
                Button("Cancelar")
                {
                    headerRouter(voltarPara: destRouter)
                }
                .font(.system(.title3, design: .rounded))
                .padding([.leading])
                Spacer()
                
                Button("OK")
                {
                    NotificationCenter.default.post(name: NSNotification.Name("Save"), object: nil)
                    headerRouter(voltarPara: destRouter)
                }
                .font(.system(.title3, design: .rounded))
                .padding([.trailing])
                .disabled(isSaveDisabled)
            }
            
        }
        HStack()
        {
            Text(nomeView)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .padding([.leading])
            Spacer()
        }.padding([.top])
    }

    func headerRouter(voltarPara: String)
    {
        switch voltarPara
        {
        case "lstAbastecimento":
            router.toListaAbastecimento()
        case "lstServico":
            router.toListaServico()
        case "lstItemServico":
            router.toListaItemServico()
        case "lstCategoria":
            router.toListaCategoria()
        case "lstCarro":
            router.toListaCarro()
        case "lstPosto":
            router.toListaPosto()
        default:
            router.toMenu()
        }
        
    }
}

