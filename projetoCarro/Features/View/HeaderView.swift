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
    var body: some View
    {
        VStack(alignment: .leading, spacing: 0.1)
        {
            HStack
            {
                PopView
                {
                    Image(systemName: "chevron.backward").foregroundColor(.blue)
                }
                Text("Menu").foregroundColor(.blue )
            }
            Text("Titulo").font(.system(.largeTitle, design: .default))
                .fontWeight(.black)
        }
    }
}

struct HeaderView_Previews: PreviewProvider
{
    static var previews: some View
    {
        HeaderView().previewLayout(.sizeThatFits)
    }
}
