//
//  NLRApp.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import SwiftUI

@main
struct NLRApp: App {
    let persistenceController = PersistenceController.shared
    let onboardingData = Onboarding.data
    
    @State private var onboardingDone = false
    
    func isFirstLaunch() -> Bool {
        if !UserDefaults.standard.bool(forKey: "hasBeenLaunchedBefore") {
            UserDefaults.standard.setValue(true, forKey: "hasBeenLaunchedBefore")
            return true
        } else {
            //TODO: Reset this to false in the base app!
            return true
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch() && !onboardingDone {
                OnboardingItemView(viewControllers: Onboarding.data.map({
                    UIHostingController(rootView: OnboardingView(page: $0))
                }), onComplete: {
                    withAnimation {
                        onboardingDone = true
                    }
                }).transition(.scale)
            } else {
                ApplicationView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .onAppear {
                        persistenceController.fetchAircrafts()
                    }
            }
        }
    }
}
