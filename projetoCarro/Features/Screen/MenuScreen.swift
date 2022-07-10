//
//  MenuScreen.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//
// baseado em: https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html
// e https://thehappyprogrammer.com/lazyvgrid-and-lazyhgrid-in-swiftui-part-1
// https://www.avanderlee.com/swiftui/navigationlink-programmatically-binding/
import SwiftUI

enum Telas
{
    case abastecimento
    
}

struct MenuScreen: View
{
    var body: some View
    {
        let collections = [
                //Make sure to change the image name to the one that you'll be using
                Collections(name: "Abastecimento", image: "gasStation", content: "Cafe. Lorem ipsum dolor sit amet."),
                Collections(name: "Serviço", image: "service", content: "Home. Lorem ipsum dolor sit amet."),
                Collections(name: "Relatórios", image: "report", content: "Commute. Lorem ipsum dolor sit amet."),
                Collections(name: "Alertas", image: "alertas", content: "Travel. Lorem ipsum dolor sit amet."),
                Collections(name: "Config", image: "config", content: "Public. Lorem ipsum dolor sit amet.")
        ]
        
        NavigationView {
            
            List(collections) { index in
                
                ZStack
                {
                    ImageLabelRow(collection: index)
                    NavigationLink(destination: AbastecimentoForm(collection: index)) {}
                    
                } //ZStack
                
            } //List
            .navigationTitle("Meu Jetta")
            
        } //NavigationView

    }
}

struct Collections: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var content: String
}
struct ImageLabelRow: View {
    
    var collection: Collections

    var body: some View {
        ZStack(alignment: .trailing) {
            Image(collection.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
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
struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}
