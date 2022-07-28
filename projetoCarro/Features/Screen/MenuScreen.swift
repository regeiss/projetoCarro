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
    // init() {
    //     let request: NSFetchRequest<Abastecimento> = Abastecimento.fetchRequest()
    //     request.fetchLimit = 1
    //     request.predicate = NSPredicate(format: "active = true")
    //     request.sortDescriptors = [NSSortDescriptor(keyPath: \Abastecimento.data, ascending: false)]
    //     _abastecimentos = FetchRequest(fetchRequest: request)
    // }

    @Environment(\.managedObjectContext) var moc
    //@FetchRequest var abastecimentos: FetchedResults<Abastecimento>
    // @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Abastecimento.data, ascending: false)], predicate: NSPredicate(format: "data = max(data)"))
    // var abastecimentos: FetchedResults<Abastecimento>
    
    // caminho da base sqlite
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    
//    let request =  NSFetchRequest<NSFetchRequestResult>(entityName:"Abastecimento")
//    @Environment(\.managedObjectContext) var moc1
//    @FetchRequest(fetchRequest: request)
    //@FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Abastecimento.data, ascending: false)])
   // var abastecimentos1: FetchedResults<Abastecimento>

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


    private func getLastSyncTimestamp() -> Int64? 
    {
        // https://stackoverflow.com/questions/10398019/core-data-how-to-fetch-an-entity-with-max-value-property?newreg=cf5949d3d96a4220ae822e26a135944d
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        request.entity = NSEntityDescription.entity(forEntityName: "Abastecimento", in: self.moc)
        request.resultType = NSFetchRequestResultType.dictionaryResultType

        let keypathExpression = NSExpression(forKeyPath: "data")
        let maxExpression = NSExpression(forFunction: "max:", arguments: [keypathExpression])

        let key = "data"

        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = key
        expressionDescription.expression = maxExpression
        expressionDescription.expressionResultType = .integer64AttributeType

        request.propertiesToFetch = [expressionDescription]

        var maxTimestamp: Int64? = nil

        do {

            if let result = try self.moc.fetch(request) as? [[String: Int64]], let dict = result.first {
            maxTimestamp = dict[key]
            }

        } catch {
            assertionFailure("Failed to fetch max timestamp with error = \(error)")
            return nil
        }

        return maxTimestamp
    }
}
let request: NSFetchRequest<Person> = Person.fetchRequest()
request.fetchLimit = 1

let predicate = NSPredicate(format: "personId ==max(personId)")
request.predicate = predicate

var maxValue: Int64? = nil
do {
    let result = try self.context.fetch(request).first
    maxValue = result?.personId
} catch {
    print("Unresolved error in retrieving max personId value \(error)")
}
