//
//  ItemServico+CoreDataProperties.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 13/11/22.
//
//

import Foundation
import CoreData


extension ItemServico {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemServico> {
        return NSFetchRequest<ItemServico>(entityName: "ItemServico")
    }

    @NSManaged public var custo: Double
    @NSManaged public var data: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var km: Int32
    @NSManaged public var nome: String?
    @NSManaged public var observacoes: String?
    @NSManaged public var doServico: Servico?

}

extension ItemServico : Identifiable {

}
