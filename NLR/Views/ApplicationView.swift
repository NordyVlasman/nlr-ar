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
    @EnvironmentObject var appManager: AppManager
    
    @State var isNumberSelection: Bool = true
    
    var backgroundColor = Color.formBackground
    
    var sheetToShow: some View {
        VStack {
            if arManager.showDamageDetails {
                DamageDetailView()
            } else if arManager.showAddDamage {
                AddDamageView()
            }
        }
    }
    
    var arkitOverlay: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    arManager.finishARScreen()
                }, label: {
                    VStack {
                        Image(systemName: "xmark.square.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                })
            }
            Spacer()
            HStack {
                Spacer()
                if appManager.isEditingModel {
                    Button(action: {
                        appManager.stopEditingModel()
                    }, label: {
                        VStack {
                            Image(systemName: "checkmark")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .mask(Circle())
                    })
                }
                Spacer()
            }
            .padding(.bottom, 6)
        }
        .padding()
    }
    
    var arView: some View {
        ARKitView()
            .environmentObject(arManager)
            .environmentObject(appManager)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                arkitOverlay
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

    }

    var body: some View {
        Group {
            if arManager.shouldShowARView {
                arView
            } else if arManager.shouldShowARCheckView {
                CheckDamageView()
                    .environmentObject(arManager)
            } else {
                AircraftsView(showNumberStyle: $isNumberSelection)
                    .environment(\.managedObjectContext, context)
                    .environmentObject(arManager)
            }
        }
    }
}
