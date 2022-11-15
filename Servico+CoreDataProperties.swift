//
//  Servico+CoreDataProperties.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 15/11/22.
//
//

import Foundation
import CoreData

extension Servico
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Servico>
    {
        return NSFetchRequest<Servico>(entityName: "Servico")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var idcategoria: UUID?
    @NSManaged public var idperiodicidade: Int16
    @NSManaged public var nome: String?
    @NSManaged public var doItemServico: NSSet?
    @NSManaged public var daCategoria: Categoria?
}

// MARK: Generated accessors for doItemServico
extension Servico
{
    @objc(addDoItemServicoObject:)
    @NSManaged public func addToDoItemServico(_ value: ItemServico)

    @objc(removeDoItemServicoObject:)
    @NSManaged public func removeFromDoItemServico(_ value: ItemServico)

    @objc(addDoItemServico:)
    @NSManaged public func addToDoItemServico(_ values: NSSet)

    @objc(removeDoItemServico:)
    @NSManaged public func removeFromDoItemServico(_ values: NSSet)
}

extension Servico : Identifiable
{

}
