//
//  ARViewController.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import Foundation
import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController {
    let sceneView: ARSCNView = ARSCNView()
    let coachingOverlayView = ARCoachingOverlayView()
    let placeVirtualObjectButton: UIButton = UIButton(type: .custom)
    
    // TODO: - Replace this with the right identifier.
    let updateQueue = DispatchQueue(label: "io.nlr.nlrar")

    var lastObjectAvailabilityUpdateTimestamp: TimeInterval?
    var isRestartAvailable = true
    var isRunning = false
    
    var manager: ARManager
    var focusSquare = FocusSquare()
    
    var placedObject: SCNNode?
    
    var session: ARSession {
        sceneView.session
    }
    
    init(arManager: ARManager) {
        self.manager = arManager
        super.init(nibName: nil, bundle: nil)
        
        manager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
}
