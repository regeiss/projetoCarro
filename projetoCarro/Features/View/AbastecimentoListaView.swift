    //
//  AbastecimentoListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 20/07/22.
//
import UIKit
import SwiftUI
import NavigationStack

struct AbastecimentoListaView: View
{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Abastecimento.data, ascending: true)
    ]) var abastecimentos: FetchedResults<Abastecimento>
    
    let dateFormatter = DateFormatter()
    //dateFormatter.dateStyle = .short
    
    var body: some View
    {
        List
        {
            ForEach(abastecimentos, id: \.self) { abastecimento in
                VStack
                {
                    Text(String(abastecimento.km))
                        .foregroundColor(.black)
                    Text((abastecimento.data ?? Date()).formatted(date: .abbreviated, time: .shortened))
                        .foregroundColor(.black)
                    Text(String(abastecimento.litros))
                    Text(String(abastecimento.valorLitro))
                }
            }
        }
    }
    
    func deleteAbastecimentos(at offsets: IndexSet) {
           for offset in offsets {
               // find this book in our fetch request
               let abastecimento = abastecimentos[offset]

               // delete it from the context
               moc.delete(abastecimento)
           }

           // save the context
           try? moc.save()
       }
}
