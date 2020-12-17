//
//  NLRApp.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import SwiftUI

@main
struct NLRApp: App {
    @StateObject private var appState = AppState.shared
    
    let persistenceController = PersistenceController.shared
    let onboardingData = Onboarding.data
    
    @State private var onboardingDone = false
    @State private var loggedIn = false
    
    @StateObject var appManager = AppManager()
    
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
            appState.route.makeView()
                .environmentObject(appState)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .sheet(item: $appState.sheetRoute,
                       onDismiss: {
                    appState.sheetRoute = nil
                }, content: {
                    $0.makeSheet()
                })
                .alert(
                    item: $appState.currentError,
                    content: {
                        $0.makeError()
                })
                .onAppear {
                    persistenceController.fetchAircrafts()
                }
//            if appManager.flowFinished {
//                withAnimation {
//                    ApplicationView()
//                        .environmentObject(appManager)
//                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                        .onAppear {
//                            persistenceController.fetchAircrafts()
//                        }
//                }
//            } else {
//                withAnimation {
//                    StartView()
//                        .environmentObject(appManager)
//                }
//            }
        }
    }
}
