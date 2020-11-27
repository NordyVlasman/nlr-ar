//
//  AircraftsDetailsView.swift
//  NLR
//
//  Created by Nordy Vlasman on 03/11/2020.
//

import SwiftUI
import CoreData

struct AircraftsDetailsView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var manager: ARManager
    
    @State var aircraft: Aircraft
    
    var body: some View {
        NavigationView {
            VStack {
                AircraftPreview()
                if !aircraft.damageNodeArray.isEmpty {
                    List {
                        Section(header: HStack {
                            Text("Issues")
                            Spacer()
                            EditButton()
                        }, content: {
                            ForEach(aircraft.damageNodeArray, id: \.self) { damageNode in
                                HStack {
                                    Text(damageNode.title!)
                                    Spacer()
                                    Text(damageNode.damageStatus.description)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        })
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                Button(action: {
                    manager.currentAircraft = aircraft
                    manager.shouldShowARView = true
                }, label: {
                    Text("Show in AR")
                })
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle(aircraft.name!)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { aircraft.damageNodeArray[$0] }.forEach(context.delete)
            
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
