//
//  Relatorios.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI
import NavigationStack

struct Relatorios: View 
{
    var body: some View 
    {
        VStack
        {
            HeaderView()
            
            ForEach(0 ..< 6) { item in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(height: 100)
            }
            
        }.padding()
    }
}

struct Relatorios_Previews: PreviewProvider 
{
    static var previews: some View 
    {
        Relatorios()
    }
}
