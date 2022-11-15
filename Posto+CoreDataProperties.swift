//
//  Posto+CoreDataProperties.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 06/11/22.
//
//

import Foundation
import CoreData


extension Posto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posto> {
        return NSFetchRequest<Posto>(entityName: "Posto")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var logo: Data?
    @NSManaged public var nome: String?
    @NSManaged public var postoAbastecimento: NSSet?

}

// MARK: Generated accessors for postoAbastecimento
extension Posto {

    @objc(addPostoAbastecimentoObject:)
    @NSManaged public func addToPostoAbastecimento(_ value: Abastecimento)

    @objc(removePostoAbastecimentoObject:)
    @NSManaged public func removeFromPostoAbastecimento(_ value: Abastecimento)

    @objc(addPostoAbastecimento:)
    @NSManaged public func addToPostoAbastecimento(_ values: NSSet)

    @objc(removePostoAbastecimento:)
    @NSManaged public func removeFromPostoAbastecimento(_ values: NSSet)

}

extension Posto : Identifiable {

}
