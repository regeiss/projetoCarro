//
//  Categoria+CoreDataProperties.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 10/11/22.
//
//

import Foundation
import CoreData


extension Categoria {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categoria> {
        return NSFetchRequest<Categoria>(entityName: "Categoria")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var nome: String?

}

extension Categoria : Identifiable {

}
