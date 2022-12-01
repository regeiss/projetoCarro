//
//  ErrorHandler.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 30/11/22.
//

import Foundation
import SwiftUI

// MARK: Enums
enum ErrorCategory
{
    case nonRetryable
    case retryable
    case requiresLogout
    case loggedOut
}

enum NetworkingError: LocalizedError 
{
    case deviceIsOffline
    case unauthorized
    case resourceNotFound
    case serverError(Error)
    case missingData
    case decodingFailed(Error)
}

// MARK: Protocols
protocol CategorizedError: Error
{
    var category: ErrorCategory { get }
}

protocol ErrorHandler
{
    func handle<T: View>(_ error: Error?, in view: T, loginStateController: LoginStateController, retryHandler: @escaping () -> Void) -> AnyView
}

// MARK: Structures
struct AlertErrorHandler: ErrorHandler
{
    // We give our handler an ID, so that SwiftUI will be able
    // to keep track of the alerts that it creates as it updates
    // our various views:
    private let id = UUID()

    func handle<T: View>(_ error: Error?, in view: T, loginStateController: LoginStateController, retryHandler: @escaping () -> Void) -> AnyView
    {
        guard error?.resolveCategory() != .requiresLogout
        else
        {
            loginStateController.state = .loggedOut
            return AnyView(view)
        }

        var presentation = error.map { Presentation(id: id, error: $0, retryHandler: retryHandler)}

        // We need to convert our model to a Binding value in order to be able to present an alert using it:
        let binding = Binding(
            get: { presentation },
            set: { presentation = $0 }
        )

        return AnyView(view.alert(item: binding, content: makeAlert))
    }
}

struct ErrorHandlerEnvironmentKey: EnvironmentKey 
{
    static var defaultValue: ErrorHandler = AlertErrorHandler()
}

struct ErrorEmittingViewModifier: ViewModifier 
{
    @EnvironmentObject var loginStateController: LoginStateController
    @Environment(\.errorHandler) var handler

    var error: Error?
    var retryHandler: () -> Void

    func body(content: Content) -> some View 
    {
        handler.handle(error,
            in: content,
            loginStateController: loginStateController,
            retryHandler: retryHandler
        )
    }
}


// MARK: Extensions
extension NetworkingError: CategorizedError 
{
    var category: ErrorCategory 
    {
        switch self 
        {
        case .deviceIsOffline, .serverError:
            return .retryable
        case .resourceNotFound, .missingData, .decodingFailed:
            return .nonRetryable
        case .unauthorized:
            return .requiresLogout
        }
    }
}

extension Error 
{
    func resolveCategory() -> ErrorCategory 
    {
        guard let categorized = self as? CategorizedError 
        else {
            // We could optionally choose to trigger an assertion
            // here, if we consider it important that all of our
            // errors have categories assigned to them.
            return .nonRetryable
        }

        return categorized.category
    }
}

private extension AlertErrorHandler 
{
    struct Presentation: Identifiable 
    {
        let id: UUID
        let error: Error
        let retryHandler: () -> Void
    }
    
    func makeAlert(for presentation: Presentation) -> Alert 
    {
        let error = presentation.error

        switch error.resolveCategory() 
        {
            case .retryable:
                return Alert(
                    title: Text("An error occured"),
                    message: Text(error.localizedDescription),
                    primaryButton: .default(Text("Dismiss")),
                    secondaryButton: .default(Text("Retry"),
                    action: presentation.retryHandler
                )
            )
            case .nonRetryable:
                return Alert(
                    title: Text("An error occured"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("Dismiss"))
            )
            case .requiresLogout:
                // We don't expect this code path to be hit, since
                // we're guarding for this case above, so we'll
                // trigger an assertion failure here.
                assertionFailure("Should have logged out")
            return Alert(title: Text("Logging out..."))
            case .loggedOut:
                assertionFailure("Should have logged out")
                return Alert(title: Text("Logging out..."))
        }
    }
}

extension EnvironmentValues 
{
    var errorHandler: ErrorHandler 
    {
        get { self[ErrorHandlerEnvironmentKey.self] }
        set { self[ErrorHandlerEnvironmentKey.self] = newValue }
    }
}

extension View 
{
    func handlingErrors(using handler: ErrorHandler) -> some View 
    {
        environment(\.errorHandler, handler)
    }
}

extension View 
{
    func emittingError(_ error: Error?, retryHandler: @escaping () -> Void) -> some View 
    {
        modifier(ErrorEmittingViewModifier(error: error, retryHandler: retryHandler))
    }
}

class LoginStateController: ObservableObject
{
    var state: ErrorCategory = .nonRetryable
}
//https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/
