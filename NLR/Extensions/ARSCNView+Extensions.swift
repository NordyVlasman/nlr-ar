//
//  ARSCNView+Extensions.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import ARKit

extension ARSCNView {
    var screenCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    func addOrUpdateAnchor(for node: SCNNode) {
        let newAnchor = ARAnchor(transform: node.simdWorldTransform)
        session.add(anchor: newAnchor)
    }
    
    func unprojectPoint(_ point: SIMD3<Float>) -> SIMD3<Float> {
        return SIMD3<Float>(unprojectPoint(SCNVector3(point)))
    }
    
    func castRay(for query: ARRaycastQuery) -> [ARRaycastResult] {
        return session.raycast(query)
    }
    
    func getRaycastQuery(for alignment: ARRaycastQuery.TargetAlignment = .any) -> ARRaycastQuery? {
        return raycastQuery(from: screenCenter, allowing: .estimatedPlane, alignment: alignment)
    }
}
