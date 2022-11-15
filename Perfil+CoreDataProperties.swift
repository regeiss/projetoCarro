//
//  Perfil+CoreDataProperties.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 06/11/22.
//
//

import Foundation
import CoreData


extension Perfil {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Perfil> {
        return NSFetchRequest<Perfil>(entityName: "Perfil")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var nome: String?
    @NSManaged public var deCarro: NSSet?

}

// MARK: Generated accessors for deCarro
extension Perfil {

    @objc(addDeCarroObject:)
    @NSManaged public func addToDeCarro(_ value: Carro)

    @objc(removeDeCarroObject:)
    @NSManaged public func removeFromDeCarro(_ value: Carro)

    @objc(addDeCarro:)
    @NSManaged public func addToDeCarro(_ values: NSSet)

    @objc(removeDeCarro:)
    @NSManaged public func removeFromDeCarro(_ values: NSSet)

}

extension Perfil : Identifiable {

}
