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
    
    var currentDamageNode: DamageNode
    
    var body: some View {
        NavigationView {
            VStack {
                Text(currentDamageNode.title ?? "")
                    .font(.title)
                
                if currentDamageNode.recordingURL != nil {
                    if audioPlayer.isPlaying {
                        
                    } else {
                        Button(action: {
                            self.audioPlayer.startPlayback(audio: currentDamageNode.recordingURL!)
                        }, label: {
                            Text("Afspelen")
                        })
                    }
                }
                Text(currentDamageNode.recordingURL!.absoluteString)
            }
            .navigationBarTitle("Damage Details")
        }
    }
}
