//
//  HeaderViewAdd.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 08/08/22.
//

import SwiftUI

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct HeaderAddView: View
{
    let router = MyRouter.shared
    var nomeView: String
    var nomeMenu: String
    var destRouter: String
    var backRouter: String
    
    var body: some View
    {
        VStack()
        {
            HStack
            {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.leading])
                    .onTapGesture
                    {
                        switch backRouter
                        {
                            case "cadastros":
                                router.toCadastros()
                            default:
                                router.toMenu()
                        }
                    }
                
                Text(nomeMenu).foregroundColor(.blue).font(.system(.title3, design: .rounded))
                Spacer()
                Image(systemName: "plus") 
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.trailing])
                    .onTapGesture 
                    {
                        switch destRouter 
                        {
                            case "abast":
                                router.toAbastecimento()
                            case "cate":
                                router.toCategoria(categoria: Categoria(), isEdit: false)
                            case "item":
                                router.toItemServico()
                            case "serv":
                                router.toServico(servico: Servico(), isEdit: false)
                            case "post":
                                router.toPosto(posto: Posto(), isEdit: false)
                            case "veic":
                                router.toCarro(carro: Carro(), isEdit: false)
                            default:
                                router.toMenu()
                        }    
                    }
            }
        
            HStack()
            {
                Text(nomeView).font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .padding([.leading])
            Spacer()
            }.padding([.top])
        }
    }
}
