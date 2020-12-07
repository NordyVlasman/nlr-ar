//
//  AudioPlayer.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/7/20.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    
    func startPlayback (audio: URL) {
        
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.setCategory(.playAndRecord, mode: .default)
            try playbackSession.overrideOutputAudioPort(.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }
        
        do {
            print("Playing \(audio.absoluteString)")
            let url = URL(fileURLWithPath: audio.path)
            let isReachable = try url.checkResourceIsReachable()
            if isReachable {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.delegate = self
                audioPlayer.play()
                isPlaying = true
            }
        } catch  let error as NSError {
            print("Playback failed. \(error.localizedDescription)")
        }
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
    
}
