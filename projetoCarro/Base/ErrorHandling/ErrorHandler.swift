//
//  ErrorHandler.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 30/11/22.
//

import Foundation
import SwiftUI

enum ValidationError: LocalizedError
{
    case missingName

    var errorDescription: String?
    {
        switch self
        {
            case .missingName:
                return "Name is a required field."
        }
    }
}

struct ErrorAlert: Identifiable
{
    var id = UUID()
    var message: String
    var dismissAction: (() -> Void)?
}

class ErrorHandling: ObservableObject
{
    @Published var currentAlert: ErrorAlert?

    func handle(error: Error)
    {
        currentAlert = ErrorAlert(message: error.localizedDescription)
    }
}
 


//https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/
//https://www.ralfebert.com/swiftui/generic-error-handling/
