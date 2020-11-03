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
    
    var body: some Scene {
        WindowGroup {
            ApplicationView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    persistenceController.fetchAircrafts()
                }
        }
    }
}
