//
//  ErrorView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/11/22.
//

//import SwiftUI
//
//struct ErrorView: View
//{
//    let errorWrapper: ErrorWrapper
//
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View
//    {
//        NavigationView
//        {
//            VStack
//            {
//                Text("An error has occurred!")
//                    .font(.title)
//                    .padding(.bottom)
//                Text(errorWrapper.error.localizedDescription)
//                    .font(.headline)
//                Text(errorWrapper.guidance)
//                    .font(.caption)
//                    .padding(.top)
//                Spacer()
//            }
//            .padding()
//            .background(.ultraThinMaterial)
//            .cornerRadius(16)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing)
//                {
//                    Button("Dismiss")
//                    {
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}
//
