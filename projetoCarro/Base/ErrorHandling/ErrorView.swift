//
//  ErrorView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/11/22.
//

import SwiftUI

struct HandleErrorsByShowingAlertViewModifier: ViewModifier
{
    @StateObject var errorHandling = ErrorHandling()

    func body(content: Content) -> some View
    {
        content
            .environmentObject(errorHandling)
            // Applying the alert for error handling using a background element
            // is a workaround, if the alert would be applied directly,
            // other .alert modifiers inside of content would not work anymore
            .background(
                EmptyView()
                    .alert(item: $errorHandling.currentAlert) { currentAlert in
                        Alert(
                            title: Text("Error"),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text("EWrro")   //errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text("Faca isso") //errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

extension View
{
    func withErrorHandling() -> some View
    {
        modifier(HandleErrorsByShowingAlertViewModifier())
    }
}
