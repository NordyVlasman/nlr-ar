//
//  ARManager.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import SwiftUI
import SceneKit
import Combine

class ARManager: ObservableObject {
    @Published var objectToPlace: VirtualObject?
    @Published var shouldShowARView = false
    var shouldShowFocusSquare = false
    
    weak var delegate: ARManagerDelegate?
    
    private func downloadVirtualObject(completionHandler: (() -> Void)? = nil) {
        guard let scene = SCNScene(named: "Art.scnassets/fullsize/fullsize.scn") else { return }
        guard let objectToPlace = VirtualObject(from: scene) else { return }
        
        self.objectToPlace = objectToPlace
        
        completionHandler?()
    }
    
    func download() {
        shouldShowFocusSquare = false
        downloadVirtualObject { [weak self] in
            self?.shouldShowFocusSquare = true
        }
    }
    
    func start() {
        delegate?.arExperienceShouldStart()
    }
    
    func pauseAR() {
        delegate?.arExperienceShouldPause()
    }
}

