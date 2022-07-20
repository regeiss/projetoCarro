//
//  MenuRow.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 19/07/22.
//
//
import SwiftUI

struct MenuRow: View
{
    var titulo: String
    
    var body: some View
    {
        ZStack(alignment: .trailing)
        {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .frame(height: 100)

            Text(titulo)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct MenuRow_Previews: PreviewProvider
{
    static var previews: some View
    {
        MenuRow(titulo: "*")
    }
}
