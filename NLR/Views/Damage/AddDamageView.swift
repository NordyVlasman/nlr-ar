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
    @State var location: String = ""
    
    @ObservedObject var audioRecorder: AudioRecorder = AudioRecorder()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Locatie van schade")) {
                    TextField("Locatie", text: $location)
                        .disabled(true)
                        .opacity(0.25)
                }
                Section(header: Text("Data van schade")) {
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
                        .foregroundColor(.red)
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
            .onAppear {
//                location = manager.currentNodeName ?? ""
            }
        }
    }
    
    
    func submitDamageNode() {
//        let damageNode = DamageNode.init(context: context)
//        let coordinates = Coordinates.init(context: context)
//
//        guard let current = manager.currentCoordinates else { manager.shouldShowDamageModal = true
//            return
//        }
//
//        guard let currentSession = manager.currentSession else {
//            manager.shouldShowDamageModal = true
//            return
//        }
//
//        coordinates.x = current.x
//        coordinates.y = current.y
//        coordinates.z = current.z
//
//        damageNode.coordinates = coordinates
//        damageNode.createdAt = Date()
//        damageNode.id = UUID()
//        damageNode.title = name
//        damageNode.damageStatus = selectedItem
//        damageNode.node = manager.currentNodeName
//        damageNode.recordingURL = currentURL
//
//        currentSession.addToDamageNodes(damageNode)
//
//        do {
//            try context.save()
//        } catch {
//            debugPrint(error)
//        }
//
//        manager.submitAddingDamageNode(with: damageNode)
    }
}
