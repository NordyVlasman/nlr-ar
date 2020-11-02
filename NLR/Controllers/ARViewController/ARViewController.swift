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

    private var lastObjectAvailabilityUpdateTimestamp: TimeInterval?
    private var isRestartAvailable = true
    private var isRunning = false
    
    var manager: ARManager
    var focusSquare = FocusSquare()
    
//    var objectToPlace: VirtualObject!
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

// MARK: - AR Setup
extension ARViewController {
    func setupView() {
        setupSceneView()
        setupPlaceVirtualObjectButton()
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
    
    func setupPlaceVirtualObjectButton() {
        sceneView.addSubview(placeVirtualObjectButton)
        
        placeVirtualObjectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeVirtualObjectButton.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor),
            placeVirtualObjectButton.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -30),
            placeVirtualObjectButton.heightAnchor.constraint(equalToConstant: 55),
            placeVirtualObjectButton.widthAnchor.constraint(equalTo: placeVirtualObjectButton.heightAnchor)
        ])
        
        placeVirtualObjectButton.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        placeVirtualObjectButton.addTarget(self, action: #selector(placeVirtualObject(sender:)), for: .touchUpInside)
        
        placeVirtualObjectButton.tintColor = .white
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
        isRunning = true
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
    
    func updateObjectAvailability() {
        if let lastUpdateTimestamp = lastObjectAvailabilityUpdateTimestamp, let timestamp = sceneView.session.currentFrame?.timestamp, timestamp - lastUpdateTimestamp < 0.5 {
            return
        } else {
            lastObjectAvailabilityUpdateTimestamp = sceneView.session.currentFrame?.timestamp
        }
        
        if let query = sceneView.getRaycastQuery(for: .horizontal), let result = sceneView.castRay(for: query).first {
            manager.objectToPlace?.mostRecentInitialPlacementResult = result
            manager.objectToPlace?.raycastQuery = query
        } else {
            manager.objectToPlace?.mostRecentInitialPlacementResult = nil
            manager.objectToPlace?.raycastQuery = nil
        }
    }
    
    @objc func placeVirtualObject(sender: Any) {
        guard isRunning, let objectToPlace = manager.objectToPlace else {
            return
        }
        
        guard !objectToPlace.isPlaced else {
            return
        }
        
        guard focusSquare.state != .initializing, let query = objectToPlace.raycastQuery else {
            return
        }
        
        let trackedRaycast = createTrackedRaycastAndSet3DPosition(
            of: objectToPlace,
            from: query,
            withInitialResult: objectToPlace.mostRecentInitialPlacementResult)
        
        objectToPlace.raycast = trackedRaycast
        objectToPlace.isHidden = false
        objectToPlace.isPlaced = true
        
        manager.shouldShowFocusSquare = false
        
    }
}
