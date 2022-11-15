//
//  Categoria+CoreDataProperties.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 15/11/22.
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
    @NSManaged public var doServico: NSSet?

}

// MARK: Generated accessors for doServico
extension Categoria {

    @objc(addDoServicoObject:)
    @NSManaged public func addToDoServico(_ value: Servico)

    @objc(removeDoServicoObject:)
    @NSManaged public func removeFromDoServico(_ value: Servico)

    @objc(addDoServico:)
    @NSManaged public func addToDoServico(_ values: NSSet)

    @objc(removeDoServico:)
    @NSManaged public func removeFromDoServico(_ values: NSSet)

}

extension Categoria : Identifiable {

}
