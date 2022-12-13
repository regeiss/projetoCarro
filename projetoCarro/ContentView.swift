//
//  ContentView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/06/22.
//
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct ContentView: View
{
    @State private var appSetupState = "App NOT setup"
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    
    static let navigationStack = NavigationStackCompat()
    @State var showMenu: Bool
    
    @StateObject private var viewModelCarro = CarroViewModel()
    
    
    var body: some View
    {
        let drag = DragGesture()
            .onEnded
        {
            if $0.translation.width < -100
            {
                withAnimation { self.showMenu = false}
            }
        }
        
        GeometryReader
        { geometry in
            
            ZStack(alignment: .leading)
            {
                NavigationStackView(transitionType: .default, navigationStack: ContentView.navigationStack)
                {
                    MainMenuScreen(showMenu: $showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width / 2 : 0)
                        .disabled(self.showMenu ? true : false)
                        .transition(.move(edge: .leading))
                }
                
                if self.showMenu
                {
                    SideMenuView(showMenu: $showMenu)
                        .frame(width: geometry.size.width / 2)
                }
            }.gesture(drag)
                .onAppear() { if !needsAppOnboarding {
                    // Scenario #2: User has completed app onboarding
                    
                    appSetupState = "App setup"
                    viewModelCarro.selecionarCarroAtivo()}}
            
            .onChange(of: needsAppOnboarding) { needsAppOnboarding in
                
                if needsAppOnboarding {
                    
                    // Scenario #2: User has completed app onboarding during current app launch
                    appSetupState = "App setup"
                }
            }                         
            .sheet(isPresented:$needsAppOnboarding) {
                // Scenario #1: User has NOT completed app onboarding
                OnBoardingView()
            }
        }
    }
}

