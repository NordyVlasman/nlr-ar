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
    let addIssueButton: UIButton = UIButton(type: .custom)
    let finishARButton: UIButton = UIButton(type: .custom)
    
    let persistenceController = PersistenceController.shared
    let feedback = UINotificationFeedbackGenerator()
    
    // TODO: - Replace this with the right identifier.
    let updateQueue = DispatchQueue(label: "io.nlr.nlrar")

    var lastObjectAvailabilityUpdateTimestamp: TimeInterval?
    var isRestartAvailable = true
    var isRunning = false
    var isAddingIssues = false
    
    var manager: ARManager
    var focusSquare = FocusSquare()
    
    var placedObject: SCNNode?
    
    var session: ARSession {
        sceneView.session
    }
    
    //MARK: - New UI
    let addVirtualObjectButton: UIButton = UIButton(type: .custom)
    let saveSessionButton: UIButton = UIButton(type: .custom)
    let undoButton: UIButton = UIButton(type: .custom)
    let finishSessionButton: UIButton = UIButton(type: .custom)
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
        session.pause()
        
    }
}
