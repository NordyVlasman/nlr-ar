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
    
    var arView: some View {
        ARKitView()
            .environmentObject(arManager)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    HStack {
                        Text("\(arManager.currentAircraft?.name ?? "")")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        VStack {
                            Text("i")
                                .font(.caption)
                                .foregroundColor(.white)
                                .bold()
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        VStack {
                            Spacer()
                            Button(action: {
                                if arManager.hasAddedDamage {
                                    arManager.finishARScreen()
                                }
                            }, label: {
                                VStack {
                                    Image(systemName: "checkmark")
                                        .font(.headline)
                                        .foregroundColor(arManager.hasAddedDamage ? Color.white : Color.white.opacity(0.8))
                                }
                                .padding()
                                .background(arManager.hasAddedDamage ? Color.green : Color.gray.opacity(0.8))
                                .mask(Circle())
                            })
                            .padding(.bottom, 5)
                            
                            Button(action: {
                                
                            }, label: {
                                VStack {
                                    Image(systemName: "archivebox")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.8))
                                .mask(Circle())
                            })
                            .padding(.bottom, 5)
                            
                            Button(action: {
                                
                            }, label: {
                                VStack {
                                    Image(systemName: "arrow.turn.down.left")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.8))
                                .mask(Circle())
                            })
                        }
                        Spacer()
                        
                        VStack {
                            Spacer()
                            Button(action: {
                                arManager.didPressAdd()
                            }, label: {
                                VStack {
                                    Image(systemName: "plus")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.blue)
                                .mask(Circle())
                            })
                        }
                    }
                }
                .padding()
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
