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
    
    var backgroundColor = Color.formBackground
    
    var sheetToShow: some View {
        VStack {
            if arManager.showDamageDetails {
                DamageDetailView()
            } else if arManager.showAddDamage {
                AddDamageView()
            } else if arManager.hasThumbUp {
                Text("Hello world")
            }
        }
    }

    var body: some View {
        Group {
            if arManager.shouldShowARView {
                ARKitView()
                    .environmentObject(arManager)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack {
                            if arManager.hasThumbUp {
                                VStack(alignment: .leading) {
                                    Text("👍")
                                }
                            } else {
                                VStack(alignment: .leading) {
                                    Text("👎")
                                }
                            }
                            Spacer()
                        }
                    )
                    .sheet(
                        isPresented: Binding {
                            !arManager.shouldShowDamageModal
                        } set: {
                            self.arManager.shouldShowDamageModal = !$0
                        }
                    ) {
                        sheetToShow
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
