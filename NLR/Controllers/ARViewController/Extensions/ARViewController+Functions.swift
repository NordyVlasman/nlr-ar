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
}
