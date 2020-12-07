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
    @State var currentURL: URL?
    
    @ObservedObject var audioRecorder: AudioRecorder = AudioRecorder()
    
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
                Section(header: Text("Voice Memo"), content: {
                    if audioRecorder.recording {
                        Button(action: {
                            audioRecorder.stopRecording() { result in
                                currentURL = result
                            }
                        }, label: {
                            Text("Stop recording")
                        })
                    } else {
                        Button(action: {
                            audioRecorder.startRecording()
                        }, label: {
                            Text("Record")
                        })
                    }
                })
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
        damageNode.currentURL = currentURL
        damageNode.addToAircraft(aircraft)
        
        do {
            try context.save()
        } catch {
            debugPrint(error)
        }
    
        manager.submitAddingDamageNode(with: damageNode)
    }
}
