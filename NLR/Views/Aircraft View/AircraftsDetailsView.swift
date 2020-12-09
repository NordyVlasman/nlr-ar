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
    @State var session: Session
    
    var showInAR: some View {
        Button(action: {
            manager.currentAircraft = aircraft
            manager.currentSession = session
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
                AircraftPreview(problems: session.damageNodeArray)
                                
                if !session.damageNodeArray.isEmpty {
                    List(session.damageNodeArray, rowContent: { row in
                        HStack {
                            Text(row.title!)
                            Spacer()
                            Text(row.damageStatus.description)
                        }
                    })
                    .listStyle(InsetGroupedListStyle())
                }
                showInAR
                Spacer()
            }

    }
}
