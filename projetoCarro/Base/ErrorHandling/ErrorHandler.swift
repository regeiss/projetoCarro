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
    case wrongDataFormat(error: Error)
    case missingData
    case creationError
    case batchInsertError
    case batchDeleteError
    case persistentHistoryChangeError
    case unexpectedError(error: Error)
    
    var errorDescription: String?
    {
        switch self
        {
            case .missingName:
                return "Name is a required field."
                    case .wrongDataFormat(let error):
            return NSLocalizedString("Could not digest the fetched data. \(error.localizedDescription)", comment: "")
        case .missingData:
            return NSLocalizedString("Found and will discard a quake missing a valid code, magnitude, place, or time.", comment: "")
        case .creationError:
            return NSLocalizedString("Failed to create a new Quake object.", comment: "")
        case .batchInsertError:
            return NSLocalizedString("Failed to execute a batch insert request.", comment: "")
        case .batchDeleteError:
            return NSLocalizedString("Failed to execute a batch delete request.", comment: "")
        case .persistentHistoryChangeError:
            return NSLocalizedString("Failed to execute a persistent history change request.", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
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
