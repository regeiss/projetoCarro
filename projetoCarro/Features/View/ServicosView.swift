//
//  Servicos.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI
import NavigationStack

struct ServicosView: View
{
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HeaderView(nomeView: "Serviços", nomeMenu: "Menu")
            VStack()
            {
                ForEach(0 ..< 6) { item in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow)
                        .frame(height: 100)
                }
                
            }.padding()
            Spacer()
        }
    }
}

struct Servicos_Previews: PreviewProvider {
    static var previews: some View {
        ServicosView()
    }
}
//struct ContentView: View {
//    var body: some View {
//            ZStack(alignment: .topLeading) {
//                Color.clear
//                VStack(alignment: .leading) {
//                    Text("Top Text")
//                        .font(.system(size: 20))
//                        .fontWeight(.medium)
//                     Text("Bottom Text")
//                        .font(.system(size: 12))
//                        .fontWeight(.regular)
//                }
//            }.frame(maxWidth: .infinity, maxHeight: .infinity)
//    }}
