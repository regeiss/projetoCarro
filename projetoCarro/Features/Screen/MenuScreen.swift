//
//  MenuScreen.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//

import SwiftUI

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }

struct MenuScreen: View
{
    
    @State var gridLayout: [GridItem] = [ GridItem() ]
    
    var body: some View
    {
        NavigationView {
    ScrollView {
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {

            ForEach(samplePhotos.indices) { index in

                Image(samplePhotos[index].name)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .shadow(color: Color.primary.opacity(0.3), radius: 1)

            }
        }
        .padding(.all, 10)
    }

    .navigationTitle("Coffee Feed")
}
    }
}

struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}
