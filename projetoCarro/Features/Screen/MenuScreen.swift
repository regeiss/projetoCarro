//
//  MenuScreen.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//
// baseado em:
// https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html
// https://thehappyprogrammer.com/lazyvgrid-and-lazyhgrid-in-swiftui-part-1
// https://stackoverflow.com/questions/56513568/ios-swiftui-pop-or-dismiss-view-programmatically
// https://github.com/matteopuc/swiftui-navigation-stack
// https://iosexample.com/a-simple-and-customizable-declarative-form-validator-for-swiftui/
import SwiftUI
import NavigationStack

struct MenuScreen: View
{
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Abastecimento.data, ascending: true)], predicate: NSPredicate(format: "data = max(data)"))
//    var abastecimentos: FetchedResults<Abastecimento>
 
    @Environment(\.managedObjectContext) var moc1
    @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Abastecimento.data, ascending: true)])
    var abastecimentos1: FetchedResults<Abastecimento>

    var body: some View
    {
        let abas = Abastecimento(context: moc1)
        
        let collections = [
                Collections(name: "Abastecimento", image: "gasStation", content: "Cafe. Lorem ipsum dolor sit amet."),
                Collections(name: "Serviço", image: "service", content: "Home. Lorem ipsum dolor sit amet."),
                Collections(name: "Relatórios", image: "report", content: "Commute. Lorem ipsum dolor sit amet."),
                Collections(name: "Alertas", image: "alertas", content: "Travel. Lorem ipsum dolor sit amet."),
                Collections(name: "Config", image: "config", content: "Public. Lorem ipsum dolor sit amet.")
        ]
            
        VStack
        {
            Text(String(abas.km))
            Text((abas.data ?? Date()).formatted(date: .abbreviated, time: .shortened))
            
            Text("Meu Jetta").font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.black)
                .padding()
            
            Spacer()
            PushView(destination: AbastecimentoView())
            {
                ImageLabelRow(collection: collections[0])
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
