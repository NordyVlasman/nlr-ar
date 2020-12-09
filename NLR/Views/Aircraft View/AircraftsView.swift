//
//  AircraftsView.swift
//  NLR
//
//  Created by Nordy Vlasman on 03/11/2020.
//

import SwiftUI
import CoreData

struct AircraftsView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var manager: ARManager
    @Binding var showNumberStyle: Bool

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Aircraft.name, ascending: true)], animation: .default)
        
    private var aircrafts: FetchedResults<Aircraft>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(aircrafts, id: \.self) { aircraft in
                    NavigationLink(
                        destination: AircraftSessionsView(aircraft: aircraft).environmentObject(manager),
                        label: {
                            Text(aircraft.name!)
                        })
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing: Button(action: {
                showNumberStyle.toggle()
            }, label: {
                Text("Selecteer nummer")
            }))
            .navigationBarTitle("Overzicht")
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { aircrafts[$0] }.forEach(context.delete)
            
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
