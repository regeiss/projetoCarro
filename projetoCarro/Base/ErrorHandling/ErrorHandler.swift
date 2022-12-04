////
////  ErrorHandler.swift
////  projetoCarro
////
////  Created by Roberto Edgar Geiss on 30/11/22.
////
//
//import Foundation
//import SwiftUI
//
//class LoginStateController: ObservableObject
//{
//    var state: ErrorCategory = .nonRetryable
//}
//
//// MARK: Enums
//
//enum ErrorCategory
//{
//    case nonRetryable
//    case retryable
//    case requiresLogout
//    case loggedOut
//}
//
//enum NetworkingError: LocalizedError 
//{
//    case deviceIsOffline
//    case unauthorized
//    case resourceNotFound
//    case serverError(Error)
//    case missingData
//    case decodingFailed(Error)
//}
//
//// MARK: Protocols
//protocol CategorizedError: Error
//{
//    var category: ErrorCategory { get }
//}
//
//protocol ErrorHandler
//{
//    func handle<T: View>(_ error: Error?, in view: T, loginStateController: LoginStateController, retryHandler: @escaping () -> Void) -> AnyView
//}
//
//// MARK: Structures
//struct AlertErrorHandler: ErrorHandler
//{
//    // We give our handler an ID, so that SwiftUI will be able
//    // to keep track of the alerts that it creates as it updates
//    // our various views:
//    private let id = UUID()
//
//    func handle<T: View>(_ error: Error?, in view: T, loginStateController: LoginStateController, retryHandler: @escaping () -> Void) -> AnyView
//    {
//        guard error?.resolveCategory() != .requiresLogout
//        else
//        {
//            loginStateController.state = .loggedOut
//            return AnyView(view)
//        }
//
//        var presentation = error.map { Presentation(id: id, error: $0, retryHandler: retryHandler)}
//
//        // We need to convert our model to a Binding value in order to be able to present an alert using it:
//        let binding = Binding(
//            get: { presentation },
//            set: { presentation = $0 }
//        )
//
//        return AnyView(view.alert(item: binding, content: makeAlert))
//    }
//}
//
//struct ErrorHandlerEnvironmentKey: EnvironmentKey 
//{
//    static var defaultValue: ErrorHandler = AlertErrorHandler()
//}
//
//struct ErrorEmittingViewModifier: ViewModifier 
//{
//    @EnvironmentObject var loginStateController: LoginStateController
//    @Environment(\.errorHandler) var handler
//
//    var error: Error?
//    var retryHandler: () -> Void
//
//    func body(content: Content) -> some View 
//    {
//        handler.handle(error,
//            in: content,
//            loginStateController: loginStateController,
//            retryHandler: retryHandler
//        )
//    }
//}
//
//
//// MARK: Extensions
//extension NetworkingError: CategorizedError 
//{
//    var category: ErrorCategory 
//    {
//        switch self 
//        {
//        case .deviceIsOffline, .serverError:
//            return .retryable
//        case .resourceNotFound, .missingData, .decodingFailed:
//            return .nonRetryable
//        case .unauthorized:
//            return .requiresLogout
//        }
//    }
//}
//
//extension Error 
//{
//    func resolveCategory() -> ErrorCategory 
//    {
//        guard let categorized = self as? CategorizedError 
//        else {
//            // We could optionally choose to trigger an assertion
//            // here, if we consider it important that all of our
//            // errors have categories assigned to them.
//            return .nonRetryable
//        }
//
//        return categorized.category
//    }
//}
//
//private extension AlertErrorHandler 
//{
//    struct Presentation: Identifiable 
//    {
//        let id: UUID
//        let error: Error
//        let retryHandler: () -> Void
//    }
//    
//    func makeAlert(for presentation: Presentation) -> Alert 
//    {
//        let error = presentation.error
//
//        switch error.resolveCategory() 
//        {
//            case .retryable:
//                return Alert(
//                    title: Text("An error occured"),
//                    message: Text(error.localizedDescription),
//                    primaryButton: .default(Text("Dismiss")),
//                    secondaryButton: .default(Text("Retry"),
//                    action: presentation.retryHandler
//                )
//            )
//            case .nonRetryable:
//                return Alert(
//                    title: Text("An error occured"),
//                    message: Text(error.localizedDescription),
//                    dismissButton: .default(Text("Dismiss"))
//            )
//            case .requiresLogout:
//                // We don't expect this code path to be hit, since
//                // we're guarding for this case above, so we'll
//                // trigger an assertion failure here.
//                assertionFailure("Should have logged out")
//            return Alert(title: Text("Logging out..."))
//            case .loggedOut:
//                assertionFailure("Should have logged out")
//                return Alert(title: Text("Logging out..."))
//        }
//    }
//}
//
//extension EnvironmentValues 
//{
//    var errorHandler: ErrorHandler 
//    {
//        get { self[ErrorHandlerEnvironmentKey.self] }
//        set { self[ErrorHandlerEnvironmentKey.self] = newValue }
//    }
//}
//
//extension View 
//{
//    func handlingErrors(using handler: ErrorHandler) -> some View 
//    {
//        environment(\.errorHandler, handler)
//    }
//}
//
//extension View 
//{
//    func emittingError(_ error: Error?, retryHandler: @escaping () -> Void) -> some View 
//    {
//        modifier(ErrorEmittingViewModifier(error: error, retryHandler: retryHandler))
//    }
//}
//
////https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/
extension ErrorHandler {
    class var defaultHandler: ErrorHandler {

        return ErrorHandler()

            // Τhe error matches and the action is called if the matches closure returns true
            .on(matches: { (error) -> Bool in
                guard let error = error as? InvalidInputsError else { return false }
                // we will ignore errors with code == 5
                return error.code != 5
            }, do: { (error) in
                showErrorAlert("Invalid Inputs")
                return .continueMatching
            })

            // Variant using ErrorMatcher which is convenient if you want to
            // share the same matching logic elsewhere
            .on(InvalidStateMatcher(), do: { (_) in
                showErrorAlert("An error has occurred. Please restart the app.")
                return .continueMatching
            })

            // Handle all errors of the same type the same way
            .onError(ofType: ParsingError.self, do: { (error) in
                doSomething(with: error)
                return .continueMatching
            })

            // Handle a specific instance of an Equatable error type
            .on(DBError.migrationNeeded, do: { (_) in
                // Db.migrate()
                return .continueMatching
            })

            // You can tag matchers or matches functions in order to reuse them with a more memorable alias.
            // You can use the same tag for many matchers. This way you can group them and handle their errors together.
            .tag(NSErrorMatcher(domain: NSURLErrorDomain, code: NSURLErrorNetworkConnectionLost),
                with: "ConnectionError"
            )
            .tag(NSErrorMatcher(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet),
                with: "ConnectionError"
            )
            .on(tag: "ConnectionError") { (_) in
                showErrorAlert("You are not connected to the Internet. Please check your connection and retry.")
                return .continueMatching
            }

            // You can use the Alamofire extensions to easily handle responses with invalid http status
            .onAFError(withStatus: 401, do: { (_) in
                showLoginScreen()
                return .continueMatching
            })
            .onAFError(withStatus: 404, do: { (_) in
                showErrorAlert("Resource not found!")
                return .continueMatching
            })

            // Handle unknown errors.
            .onNoMatch(do: { (_)  in
                showErrorAlert("An error occurred! Please try again. ")
                return .continueMatching
            })

            // Add actions - like logging - that you want to perform each time - whether the error was matched or not
            .always(do: { (error) in
                Logger.log(error)
                return .continueMatching
            })
    }
}
