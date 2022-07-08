//
//  MenuScreen.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//
// baseado em: https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html
// e https://thehappyprogrammer.com/lazyvgrid-and-lazyhgrid-in-swiftui-part-1
import SwiftUI

struct MenuScreen: View
{
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                VStack(alignment: .center, spacing: 0.2)
                {
                    Image("gasStation")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                    NavigationLink("Abastecimento", destination: AbastecimentoForm()) {}
                    
                    HStack(alignment: .top, spacing: 0.2)
                    {
                        Image("service")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                            .onTapGesture {
                                AbastecimentoForm()
                            }
                        Image("report")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                            .onTapGesture {
                                AbastecimentoForm()
                            }
                    }.padding()
                    HStack(alignment: .top, spacing: 0.2)
                    {
                        Image("config")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                            .onTapGesture {
                                AbastecimentoForm()
                            }
                        Image("alertas")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                            .onTapGesture {
                                AbastecimentoForm()
                            }
                    }.padding()
                }.padding()
            }
            Spacer()
            //https://blog.devgenius.io/swiftui-tutorial-working-with-navigationview-2f72c18a30d1
//            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10)
//            {
//                ForEach(samplePhotos.indices) { index in
//                    ZStack
//                    {
//                        NavigationLink(destination: AbastecimentoForm()) {Text("********").opacity(0.8)}
//                        Image(samplePhotos[index].name)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .frame(height: gridLayout.count == 1 ? 200 : 100)
//                            .cornerRadius(10)
//                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
//                            .allowsHitTesting(false)
//
//                    }
//        }
//        .padding(.all, 10)
//        .animation(.interactiveSpring(), value: gridLayout.count)
//    }


    }
        .navigationTitle("Coffee Feed")
    }
}

struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}
