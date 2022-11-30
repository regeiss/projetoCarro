//
//  ErrorWrapper.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/11/22.
//
import Foundation

struct ErrorWrapper: Identifiable
{
    let id: UUID
    let error: Error
    let guidance: String

    init(id: UUID = UUID(), error: Error, guidance: String)
    {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
//https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/
