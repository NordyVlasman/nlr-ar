//
//  AircraftsDetailsView.swift
//  NLR
//
//  Created by Nordy Vlasman on 03/11/2020.
//

import SwiftUI
import CoreData

struct AircraftSessionsView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject var manager: ARManager = ARManager()
    @EnvironmentObject var aircraftManager: AircraftManager

//    @State var aircraft: Aircraft
    
    var showInAR: some View {
        Button(action: {
            let session = Session.init(context: context)
            session.createdBy = "NLR"
            session.createdAt = Date()
            
            aircraftManager.currentAircraft!.addToSession(session)
            PersistenceController.shared.saveContext()
            manager.currentSession = session
            AppState.shared.route = .arView
        }, label: {
            HStack {
                Text("Start a new Session")
                    .foregroundColor(.white)
            }
        })
        .padding()
        .background(Color.blue)
        .cornerRadius(7)
        .padding()
    }
    
    var body: some View {
        NavigationView {
            VStack  {
                AircraftPreview(problems: nil)
                if !aircraftManager.currentAircraft!.sessionArray.isEmpty {
                    List(aircraftManager.currentAircraft!.sessionArray, rowContent: { row in
                        NavigationLink(
                            destination: AircraftsDetailsView(aircraft: aircraftManager.currentAircraft!, session: row).environmentObject(manager),
                            label: {
                                Text(row.createdAt?.toString(dateFormat: "dd-MM-YYYY") ?? "")
                                Spacer()
                                Text(row.createdBy!)
                            })
                    })
                    .listStyle(InsetGroupedListStyle())
                }
                showInAR
                Spacer()
            }
            .navigationBarTitle(aircraftManager.currentAircraft!.name ?? "")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
