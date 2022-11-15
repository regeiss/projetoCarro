//
//  LoginApple.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 31/10/22.
//

import SwiftUI
import AuthenticationServices

final class SignInWithApple: UIViewRepresentable
{
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton
    {
        return ASAuthorizationAppleIDButton()
    }
}
