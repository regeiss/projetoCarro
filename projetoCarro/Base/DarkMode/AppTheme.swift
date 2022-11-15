//
//  AppTheme.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 09/10/22.
//

import Foundation
import SwiftUI

class AppThemeViewModel: ObservableObject {
    
    @AppStorage("modoEscuro") var isDarkMode: Bool = true                           // also exists in DarkModeViewModifier()
    
}

struct DarkModeViewModifier: ViewModifier {
    @ObservedObject var appThemeViewModel: AppThemeViewModel = AppThemeViewModel()
    
    public func body(content: Content) -> some View {
        content
            .preferredColorScheme(appThemeViewModel.isDarkMode ? .dark : appThemeViewModel.isDarkMode == false ? .light : nil)
            
    }
}
