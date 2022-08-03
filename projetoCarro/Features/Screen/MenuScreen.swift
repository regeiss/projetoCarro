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
    @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Abastecimento.data, ascending: false)])//, predicate: NSPredicate(format: "data == max(data)"))
    var abastecimentos: FetchedResults<Abastecimento>
    
    // caminho da base sqlite
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    
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
            UltimoAbastecimentoView(abastecimentos: ultimoAbastecimento)
            Text("*******").font(.system(.largeTitle, design: .rounded))
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
            }.onAppear(perform: {print(paths[0])})
            
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
