//
//  ARViewController+ARViewDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import Foundation
import ARKit

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async { [weak self] in
            self?.updateFocusSquare()
            self?.updateObjectAvailability()
        }
    }
}

