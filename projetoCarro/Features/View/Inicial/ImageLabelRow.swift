//
//  ImageLabelRow.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 26/07/22.
//

import SwiftUI

struct ImageLabelRow: View
{
    let router = MyRouter.shared
    var collection: Collections
    let height: CGFloat = 110
    
    var body: some View
    {
        ZStack(alignment: .bottomTrailing)
        {
            // TODO: Verificar o tamanho da imagem e do retangulo
//            Image(collection.image)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//                .frame(height: collection.name == "Abastecimento" ? 150 : height)
//                .cornerRadius(20)
//                .overlay(
//                    Rectangle()
//                        .foregroundColor(.black)
//                        .cornerRadius(20)
//                        .opacity(0.2)
//                        .frame(height: height)
                       // .onTapGesture { screenRouter(indice: collection.id)}
//                    )
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .frame(height: collection.name == "Abastecimento" ? 150 : height)
                .onTapGesture { screenRouter(indice: collection.id)}
            Text(collection.name)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(.orange)
                .offset(x: 1.0, y: 10)
                .padding()
                //.background(
                //        Image("collection.image") 
                //            .resizable())
                .onTapGesture { screenRouter(indice: collection.id)}
            if collection.name == "Abastecimento"
            {
                UltimoAbastecimentoView().offset(x: -10, y: -50)
            }
        }.frame(minWidth: 230, maxWidth: .infinity, minHeight: height, maxHeight: 150)
    }

    func screenRouter(indice: Int)
    {
        switch indice 
        {
            case 0:
                router.toListaAbastecimento()
            case 1:
                router.toItemServico()
            case 2:
                router.toRelatorios()
            case 3:
                router.toAlertas()
            case 4:
                router.toCadastros()
            default:
                router.toMenu()
        }
        
    }
}

