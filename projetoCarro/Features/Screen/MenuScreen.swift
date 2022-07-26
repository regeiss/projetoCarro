//
//  MenuScreen.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//
// baseado em: https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html
// e https://thehappyprogrammer.com/lazyvgrid-and-lazyhgrid-in-swiftui-part-1
// https://stackoverflow.com/questions/56513568/ios-swiftui-pop-or-dismiss-view-programmatically
// https://github.com/matteopuc/swiftui-navigation-stack
// https://iosexample.com/a-simple-and-customizable-declarative-form-validator-for-swiftui/
import SwiftUI
import NavigationStack

struct MenuScreen: View
{    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \Abastecimento.data, ascending: true)],
        predicate: NSPredicate(format: "data == max(data)"))
        var abastecimento: FetchedResults<Abastecimento>
    
    var body: some View
    {
        let collections = [
                //Make sure to change the image name to the one that you'll be using
                Collections(name: "Combustível", image: "gasStation", content: "Cafe. Lorem ipsum dolor sit amet."),
                Collections(name: "Serviço", image: "service", content: "Home. Lorem ipsum dolor sit amet."),
                Collections(name: "Relatórios", image: "report", content: "Commute. Lorem ipsum dolor sit amet."),
                Collections(name: "Alertas", image: "alertas", content: "Travel. Lorem ipsum dolor sit amet."),
                Collections(name: "Config", image: "config", content: "Public. Lorem ipsum dolor sit amet.")
        ]
            

//        ultimoAbastecimento.id = $abastecimento.id
//        ultimoAbastecimento.km = abastecimento.km
//        ultimoAbastecimento.completo = abastecimento.completo
//        ultimoAbastecimento.litros = abastecimento.litros
//        ultimoAbastecimento.data = abastecimento.data
//        ultimoAbastecimento.valorLitro = abastecimento.valorLitro
//        ultimoAbastecimento.valorTotal = abastecimento.valorTotal

        VStack
        {
            for abas in abastecimento
            {
                let x = abastecimento.km
            }

            Text("Meu Jetta").font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.black)
                .padding()
            Spacer()
            PushView(destination: AbastecimentoView())
            {
                ImageLabelRow(collection: collections[0])
                //print(abastecimento.km)
            }
            HStack
            {
                PushView(destination: ServicosView())
                {
                    ImageLabelRow(collection: collections[1])
                }
                PushView(destination: RelatoriosView())
                {
                    ImageLabelRow(collection: collections[2])
                    
                }
            }
            PushView(destination: AlertasView())
            {
                ImageLabelRow(collection: collections[3])
                
            }
            PushView(destination: ConfiguracaoView())
            {
                ImageLabelRow(collection: collections[4])
            }
        }.padding()
    }
}

struct Collections: Identifiable
{
    var id = UUID()
    var name: String
    var image: String
    var content: String
}

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
            VStack{
            Text(collection.name)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.white)
                .padding()
            
            if collection.name == "Combustível"
            {
                Text("139878").foregroundColor(.white)
                Text("25/07/2022").foregroundColor(.white)
                Text("20 litros").foregroundColor(.white)
            }}
        }
    }
}
