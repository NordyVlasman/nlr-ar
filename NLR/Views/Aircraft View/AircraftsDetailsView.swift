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
        VStack {
            List {
//                    if aircraft.damageNodeArray != nil {
                ForEach(aircraft.damageNodeArray, id: \.self) { damageNode in
                    Text(damageNode.title!)
                }
//                    }
            }
            .listStyle(InsetGroupedListStyle())
            Button(action: {
                manager.currentAircraft = aircraft
                manager.shouldShowARView = true
            }, label: {
                Text("Show in AR")
            })
        }
        .navigationBarTitle(aircraft.name!)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AircraftsDetailsView_Previews: PreviewProvider {
    @State static var aircraft = Aircraft()
    static var previews: some View {
        AircraftsDetailsView(aircraft: aircraft)
    }
}
