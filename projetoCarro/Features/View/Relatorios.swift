//
//  Relatorios.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 14/07/22.
//

import SwiftUI

struct Relatorios: View 
{
    var body: some View 
    {
      PopView 
        {
            Text("<")
        }
	
       Text("Relatorios")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding()
        
        ForEach(0 ..< 6) { item in
        RoundedRectangle(cornerRadius: 10)
	        .fill(Color.blue)
	        .frame(height: 100)
    }
    }
}

struct Relatorios_Previews: PreviewProvider 
{
    static var previews: some View 
    {
        Relatorios()
    }
}
