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
    @EnvironmentObject var manager: ARManager
    
    @State var aircraft: Aircraft
    
    var showInAR: some View {
        Button(action: {
            let session = Session.init(context: context)
            session.createdBy = "NLR"
            session.createdAt = Date()
            
            aircraft.addToSession(session)
            
            manager.currentSession = session
            manager.currentAircraft = aircraft
            manager.shouldShowARView = true
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
            VStack {
                AircraftPreview(problems: nil)
                if !aircraft.sessionArray.isEmpty {
                    List(aircraft.sessionArray, rowContent: { row in
                        NavigationLink(
                            destination: AircraftsDetailsView(aircraft: aircraft, session: row).environmentObject(manager),
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
            .navigationBarTitle(aircraft.name!)

    }
}
