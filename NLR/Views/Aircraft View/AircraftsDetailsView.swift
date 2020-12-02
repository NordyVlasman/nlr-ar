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
    
    var showInAR: some View {
        Button(action: {
            manager.currentAircraft = aircraft
            manager.shouldShowARView = true
        }, label: {
            HStack {
                Text("Show in AR")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "arkit")
                    .foregroundColor(.white)
            }
        })
        .padding()
        .background(Color.blue)
        .cornerRadius(7)
        .padding()
    }
    
    var body: some View {
            VStack {
                AircraftPreview(problems: aircraft.damageNodeArray)
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
                showInAR
                Spacer()
            }
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
