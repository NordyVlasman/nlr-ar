//
//  AddDamageView.swift
//  NLR
//
//  Created by Nordy Vlasman on 03/11/2020.
//

import SwiftUI

struct AddDamageView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var manager: ARManager
    
    @State var name: String = ""
    @State var selectedItem: DamageState = .Damage
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Issue", text: $name)
                    Picker(selection: $selectedItem, label: Text("Status"), content: {
                        ForEach(DamageState.allCases, id: \.self) { value in
                            Text(value.description)
                                .tag(value)
                        }
                    })
                    
                }
                Section(header: Text("Verstuur"), content: {
                    Button(action: {
                        submitDamageNode()
                    }, label: {
                        Text("Button")
                    })
                })
            }
            .background(Color.white)
            .navigationBarTitle("Issue toevoegen")
        }
    }
    
    func submitDamageNode() {
        let damageNode = DamageNode.init(context: context)
        let coordinates = Coordinates.init(context: context)
        
        guard let current = manager.currentCoordinates else { manager.shouldShowDamageModal = true
            return
        }
        
        guard let aircraft = manager.currentAircraft else {
            manager.shouldShowDamageModal = true
            return
        }
        
        coordinates.x = current.x
        coordinates.y = current.y
        coordinates.z = current.z

        damageNode.coordinates = coordinates
        damageNode.createdAt = Date()
        damageNode.id = UUID()
        damageNode.title = name
        damageNode.damageStatus = selectedItem
        damageNode.node = manager.currentNodeName
        damageNode.addToAircraft(aircraft)
        
        do {
            try context.save()
        } catch {
            debugPrint(error)
        }
    
        manager.submitAddingDamageNode(with: damageNode)
    }
}

struct AddDamageView_Previews: PreviewProvider {
    static var previews: some View {
        AddDamageView()
    }
}
