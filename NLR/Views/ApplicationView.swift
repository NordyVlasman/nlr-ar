//
//  ContentView.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import SwiftUI

struct ApplicationView: View {
    @Environment(\.managedObjectContext) private var context
    
    @StateObject var arManager = ARManager()

    var body: some View {
        Group {
            if arManager.shouldShowARView {
                ARKitView()
                    .environmentObject(arManager)
                    .edgesIgnoringSafeArea(.all)
                    .sheet(
                        isPresented: Binding {
                            !arManager.shouldShowDamageModal
                        } set: {
                            self.arManager.shouldShowDamageModal = !$0
                        }
                    ) {
                        AddDamageView()
                            .environment(\.managedObjectContext, context)
                            .environmentObject(arManager)
                    }
                    .onAppear(perform: {
                        arManager.start()
                        arManager.download()
                    })
            } else {
                AircraftsView()
                    .environment(\.managedObjectContext, context)
                    .environmentObject(arManager)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView()
    }
}
