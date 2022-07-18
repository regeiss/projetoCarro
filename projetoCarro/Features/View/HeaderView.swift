//
//  HeaderView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 15/07/22.
//

import SwiftUI
import NavigationStack

struct HeaderView: View
{
    var nomeView: String
    var nomeMenu: String
    
    var body: some View
    {
        VStack()
        {
            HStack
            {
                PopView
                {
                    Image(systemName: "chevron.backward").foregroundColor(.blue)
                        .padding([.leading])
                }
                Text(nomeMenu).foregroundColor(.blue )
                Spacer()
                Image(systemName: "house").foregroundColor(.blue)
                    .padding([.trailing])
            }
            HStack
            {
            Text(nomeView).font(.system(.title, design: .default))
                .fontWeight(.black)
                .padding([.leading])
            Spacer()
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider
{
    static var previews: some View
    {
        HeaderView(nomeView: "*", nomeMenu: "*")
    }
}
