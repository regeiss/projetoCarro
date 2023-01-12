//
//  Abastecimento+CoreDataProperties.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 10/11/22.
//
//

import Foundation
import CoreData

extension Abastecimento
{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Abastecimento>
    {
        return NSFetchRequest<Abastecimento>(entityName: "Abastecimento")
    }

    @NSManaged public var completo: Bool
    @NSManaged public var data: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var km: Int32
    @NSManaged public var litros: Double
    @NSManaged public var media: Double
    @NSManaged public var valorLitro: Double
    @NSManaged public var valorTotal: Double
    @NSManaged public var doCarro: Carro?
    @NSManaged public var doPosto: Posto?
}

extension Abastecimento: Identifiable
{

}
