//
//  Snippets.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 03/11/22.
//

/*
The Plan

We want to implement a simple app onboarding flow, which satisfies the following criteria:
    When an app user launches the app for the first time, or has previously launched the app but did not complete onboarding, we will display a single onboarding view
    This single onboarding view should be displayed modally
    The onboarding view will contain an image an some text, explaining key points relating to the app
    The onboarding view will also contain a button, which the user can press to indicate that they have finished onboarding
    As this is a modal view, the user can also swipe down to dismiss the onboarding view
    When the user dismisses the onboarding view by swiping down, we will also consider onboarding as complete
    Once onboarding is complete, the app will perform setup actions
    If the user is subsequently launching the app, and has previously already onboarded, the app will perform setup actions on app launch

Based on the above criteria, we can extract three separate scenarios relating to onboarding which we will need to handle when the app is launched:

    User has NOT completed app onboarding
    User has completed app onboarding during the current app launch
    User has completed app onboarding during a previous app launch

*/

// https://dps923.ca/notes/core-data-multi-entities.html
// https://www.hackingwithswift.com/forums/swiftui/list-nsfetchedresultscontroller-sections/9379
// https://stackoverflow.com/questions/58574847/how-to-dynamically-create-sections-in-a-swiftui-list-foreach-and-avoid-unable-t
// https://drawsql.app/teams/rg-3/diagrams/projetoc
// https://zendesk.engineering/app-onboarding-with-swiftui-23d970ab24d4
struct OnboardingView: View {
    
    var body: some View {
        
        // #1
        VStack {
            Spacer(minLength: 150)
            Image(systemName: "wand.and.stars")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80, alignment: .center)
            Text("Welcome To My App")
                .font(Font.title2.bold().lowercaseSmallCaps())
                .multilineTextAlignment(.center)
            Spacer(minLength: 60)
            Text("Something something this app 🤪")
            Spacer(minLength: 30)
            Text("And another something!")
            Spacer(minLength: 30)
            Text("And finally 🥳...some...thing")
            
            // #2
            OnboardingButton()
        }
        .background(Color.gray)
        .foregroundColor(.white)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct OnboardingButton: View {
    
    // #1
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
    
    var body: some View {
        GeometryReader { proxy in
            LazyHStack {
                Button(action: {
                    
                    // #2
                    needsAppOnboarding = false
                }) {
                    Text("Finish Setup")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .font(Font.title2.bold().lowercaseSmallCaps())
                }
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(40)
                .frame(minWidth: 0, maxWidth: proxy.size.width-40)
            }
            .frame(width: proxy.size.width, height: proxy.size.height/1.5)
        }
    }
}
