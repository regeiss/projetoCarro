//
//  HeaderView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 15/07/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct HeaderView: View
{
    let router = MyRouter.shared
    var nomeView: String
    var nomeMenu: String
    
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
                    .onTapGesture {
                        router.toMenu()
                    }
                
                Text(nomeMenu).foregroundColor(.blue).font(.system(.title3, design: .rounded))
                Spacer()
                Image(systemName: "house")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.trailing])
                    .onTapGesture {
                        router.toMenu()
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
