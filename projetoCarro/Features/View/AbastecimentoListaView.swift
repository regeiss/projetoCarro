//
//  AbastecimentoListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 20/07/22.
//

import SwiftUI
import NavigationStack

struct AbastecimentoListaView: View
{
    var abastecimentos: [Abastecimento]
    
    var body: some View
    {
        List
        {
            ForEach(abastecimentos)
            { item in
                AbastecimentoListaItemView()
            }
        }
    }
}

struct AbastecimentoListaView_Previews: PreviewProvider
{
    static var previews: some View
    {
        AbastecimentoListaView(abastecimentos: Abastecimento.dummyData)
    }
}
