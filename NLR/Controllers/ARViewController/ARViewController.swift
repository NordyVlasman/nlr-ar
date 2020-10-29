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
    
    // TODO: - Replace this with the right identifier.
    let updateQueue = DispatchQueue(label: "io.nvlas.nlr")

    private var isRestartAvailable = true
    private var isRunning = false
    
    var manager: ARManager
    var focusSquare = FocusSquare()
    var session: ARSession {
        sceneView.session
    }
    
    init(arManager: ARManager) {
        self.manager = arManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        restartExperience()
    }
}

// MARK: - AR Setup
extension ARViewController {
    func setupView() {
        setupSceneView()
    }
    
    func setupSceneView() {
        view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.isAutoFocusEnabled = true
        configuration.isLightEstimationEnabled = true
        configuration.environmentTexturing = .automatic
        configuration.planeDetection = [.horizontal]
        configuration.wantsHDREnvironmentTextures = true
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.debugOptions = [.showFeaturePoints, .showConstraints]
        
        sceneView.session.run(configuration)
        setupCoachingOverlay()
    }
    
    func restartExperience() {
        guard isRestartAvailable else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.isRestartAvailable = false
        }
        
        resetTracking()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: { [weak self] in
            self?.isRestartAvailable = true
        })
    }
}
