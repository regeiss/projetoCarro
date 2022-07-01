//
//  MenuScreen.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//
// baseado em: https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html
// e https://thehappyprogrammer.com/lazyvgrid-and-lazyhgrid-in-swiftui-part-1
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
                    .frame(height: gridLayout.count == 1 ? 200 : 100)
                    .cornerRadius(10)
                    .shadow(color: Color.primary.opacity(0.3), radius: 1)

            }
        }
        .padding(.all, 10)
        .animation(.interactiveSpring(), value: gridLayout.count)
    }
    .navigationTitle("Coffee Feed")
    .toolbar {
    ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
            self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 4 + 1)
        }) {
            Image(systemName: "square.grid.2x2")
                .font(.title)
                .foregroundColor(.primary)
        }
    }
}
}
    }
}

struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}
