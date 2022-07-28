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
import CoreData
import SwiftUI
import NavigationStack

struct MenuScreen: View
{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Abastecimento.data, ascending: false)], predicate: NSPredicate(format: "data = max(data)"))
    var abastecimentos: FetchedResults<Abastecimento>
 
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    
//    let request =  NSFetchRequest<NSFetchRequestResult>(entityName:"Abastecimento")
//    @Environment(\.managedObjectContext) var moc1
//    @FetchRequest(fetchRequest: request)
    //@FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Abastecimento.data, ascending: false)])
   // var abastecimentos1: FetchedResults<Abastecimento>
// mostra o caminho da base sqllite
//    let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//    let docsDir = dirPaths[0]
//    print(docsDir)

    var body: some View
    {
        //
        let collections = [
                Collections(name: "Abastecimento", image: "gasStation", content: "."),
                Collections(name: "Serviço", image: "service", content: "."),
                Collections(name: "Relatórios", image: "report", content: "."),
                Collections(name: "Alertas", image: "alertas", content: "."),
                Collections(name: "Config", image: "config", content: ".")
        ]

        let ultimoAbastecimento = Abastecimento(context: moc)

        VStack
        {
            VStack
            {
                HStack
                {
                    Text("Última vez: ")
                    Text((ultimoAbastecimento.data ?? Date()).formatted(date: .abbreviated, time: .shortened))
                        .font(.body)
                        .foregroundColor(.black)
                }.onAppear(perform: {print(paths[0])})
                
                HStack
                {
                    Text("Odometro: ")
                    Text(String(ultimoAbastecimento.km))
                        .font(.body)
                        .foregroundColor(.black)
                }
                
                HStack
                {
                    Text("Volume: ")
                    Text(String(format: "%.2f", ultimoAbastecimento.litros))
                        .font(.body)
                        .foregroundColor(.black)
                }
                
                HStack
                {
                    Text("Valor: ")
                    Text(String(format: "%.2f", ultimoAbastecimento.valorTotal))
                        .font(.body)
                        .foregroundColor(.black)
                }
            }

            Text("VW Jetta").font(.system(.largeTitle, design: .rounded))
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

