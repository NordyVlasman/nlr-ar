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
    @State private var loggedIn = false
    
    let persistenceController = PersistenceController.shared
        
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
        }
    }
}
