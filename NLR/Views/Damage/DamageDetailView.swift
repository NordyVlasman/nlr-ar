//
//  DamageDetailView.swift
//  NLR
//
//  Created by Nordy Vlasman on 04/11/2020.
//

import SwiftUI

struct DamageDetailView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var manager: ARManager
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(manager.currentDamageNode?.title ?? "")
                    .font(.title)
                
                if manager.currentDamageNode?.recordingURL != nil {
                    if audioPlayer.isPlaying {
                        
                    } else {
                        Button(action: {
                            self.audioPlayer.startPlayback(audio: manager.currentDamageNode!.recordingURL!)
                        }, label: {
                            Text("Afspelen")
                        })
                    }
                }
                Text(manager.currentDamageNode?.recordingURL?.absoluteString ?? "")
            }
            .navigationBarTitle("Damage Details")
        }
        .onDisappear {
           manager.showDamageDetails = false
        }
    }
}
