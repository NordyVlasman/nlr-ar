//
//  ARViewController+Functions.swift
//  NLR
//
//  Created by Nordy Vlasman on 02/11/2020.
//

import SceneKit
import Foundation
import ARKit

extension ARViewController {
    func setTransform(of virtualObject: VirtualObject, with result: ARRaycastResult) {
        virtualObject.simdWorldTransform = result.worldTransform
        virtualObject.scale = .init(x: 0.01, y: 0.01, z: 0.01)
    }
    
    func createTrackedRaycastAndSet3DPosition(of virtualObject: VirtualObject, from query: ARRaycastQuery,
                                              withInitialResult initialResult: ARRaycastResult? = nil) -> ARTrackedRaycast? {
        
        if let initialResult = initialResult {
            setTransform(of: virtualObject, with: initialResult)
        }
        
        return session.trackedRaycast(query) { (results) in
            self.setVirtualObject3DPosition(results, with: virtualObject)
        }
    }
    
    private func setVirtualObject3DPosition(_ results: [ARRaycastResult], with virtualObject: VirtualObject) {
        guard let result = results.first else {
            fatalError("Unexpected case: the update handler is always supposed to return at least one result.")
        }
        
        setTransform(of: virtualObject, with: result)
        
        // If the virtual object is not yet in the scene, add it.
        if virtualObject.parent == nil {
            sceneView.scene.rootNode.addChildNode(virtualObject)
            virtualObject.isPlaced = true
            virtualObject.shouldUpdateAnchor = true
        }
        
        if virtualObject.shouldUpdateAnchor {
            virtualObject.shouldUpdateAnchor = false
            updateQueue.async { [weak self] in
                self?.sceneView.addOrUpdateAnchor(for: virtualObject)
            }
        }
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
        if let lastUpdateTimestamp = lastObjectAvailabilityUpdateTimestamp,
           let timestamp = sceneView.session.currentFrame?.timestamp, timestamp - lastUpdateTimestamp < 0.5 {
            return
        } else {
            lastObjectAvailabilityUpdateTimestamp = sceneView.session.currentFrame?.timestamp
        }
        
        if let query = sceneView.getRaycastQuery(for: .horizontal),
           let result = sceneView.castRay(for: query).first {
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
