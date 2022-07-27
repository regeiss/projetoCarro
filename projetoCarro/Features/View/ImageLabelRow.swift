//
//  ImageLabelRow.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 26/07/22.
//

import SwiftUI

struct ImageLabelRow: View
{
    var collection: Collections

    var body: some View
    {
        ZStack(alignment: .trailing)
        {
            Image(collection.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 155)
                .cornerRadius(20)
                .overlay(
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .opacity(0.4)
                )

            Text(collection.name)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.white)
                .padding()
        }
    }
}
