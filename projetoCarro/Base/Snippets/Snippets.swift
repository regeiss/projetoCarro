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

// https://pmnh1.atlassian.net/jira/software/projects/PROJ/boards/1
//                    PhotosPicker(
//                        selection: $selectedItem,
//                        matching: .images,
//                        photoLibrary: .shared()) {
//                            Text("Selecione uma imagem")
//                        }
//                        .onChange(of: selectedItem) { newItem in
//                            Task {
//                                // Retrieve selected asset in the form of Data
//                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                                    selectedImageData = data
//                                }
//                            }
//                        }
//
//                    if let selectedImageData,
//                       let uiImage = UIImage(data: selectedImageData)
//                    {
//                        Image(uiImage: uiImage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 250, height: 250)
//                    }

// https://pmnh1.atlassian.net/wiki/spaces/DM/pages/36274177/Create+a+Slide+Down+Error+Alert+with+SwiftUI+and+Animations
