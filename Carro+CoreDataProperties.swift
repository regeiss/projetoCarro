//
//  Carro+CoreDataProperties.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 26/12/22.
//
//

import Foundation
import CoreData


extension Carro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Carro> {
        return NSFetchRequest<Carro>(entityName: "Carro")
    }

    @NSManaged public var ano: Int16
    @NSManaged public var ativo: Bool
    @NSManaged public var chassis: String?
    @NSManaged public var id: UUID?
    @NSManaged public var idperfil: UUID?
    @NSManaged public var marca: String?
    @NSManaged public var modelo: String?
    @NSManaged public var nome: String?
    @NSManaged public var placa: String?
    @NSManaged public var padrao: Bool
    @NSManaged public var carroAbastecimento: NSSet?
    @NSManaged public var dePerfil: NSSet?

}

// MARK: Generated accessors for carroAbastecimento
extension Carro {

    @objc(addCarroAbastecimentoObject:)
    @NSManaged public func addToCarroAbastecimento(_ value: Abastecimento)

    @objc(removeCarroAbastecimentoObject:)
    @NSManaged public func removeFromCarroAbastecimento(_ value: Abastecimento)

    @objc(addCarroAbastecimento:)
    @NSManaged public func addToCarroAbastecimento(_ values: NSSet)

    @objc(removeCarroAbastecimento:)
    @NSManaged public func removeFromCarroAbastecimento(_ values: NSSet)

}

// MARK: Generated accessors for dePerfil
extension Carro {

    @objc(addDePerfilObject:)
    @NSManaged public func addToDePerfil(_ value: Perfil)

    @objc(removeDePerfilObject:)
    @NSManaged public func removeFromDePerfil(_ value: Perfil)

    @objc(addDePerfil:)
    @NSManaged public func addToDePerfil(_ values: NSSet)

    @objc(removeDePerfil:)
    @NSManaged public func removeFromDePerfil(_ values: NSSet)

}

extension Carro : Identifiable {

}
