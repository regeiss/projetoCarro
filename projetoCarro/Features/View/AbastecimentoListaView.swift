    //
//  AbastecimentoListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 20/07/22.
//
import SwiftUI
import NavigationStack

struct AbastecimentoListaView: View
{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Abastecimento.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Abastecimento.data, ascending: true)
    ]) var abastecimentos: FetchedResults<Abastecimento>
    
    var body: some View
    {
        List
        {
            ForEach(abastecimentos, id: \.self) { abastecimento in
                VStack
                {
                    Text(String(abastecimento.km))
                    Text((abastecimento.data ?? Date()).formatted(date: .abbreviated, time: .shortened))
                    Text(String(format: "%.3f", abastecimento.litros))
                    Text(String(format: "%.3f", abastecimento.valorLitro))
                    Text(String(format: "%.2f", abastecimento.valorTotal))
                    Text("Completo")
                }
            }.onDelete(perform: deleteAbastecimentos)
        }
    }
    
    func deleteAbastecimentos(at offsets: IndexSet)
    {
        for offset in offsets
        {
            let abastecimento = abastecimentos[offset]
            moc.delete(abastecimento)
        }
        
        try? moc.save()
    }
}
