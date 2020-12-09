//
//  ARBaseViewController+Functions.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/2/20.
//

import Foundation
import package_arbase
import ARKit
import SceneKit

extension ARViewController {
    func prepareObject() {
////        guard let damageNodeArray = arManager.currentAircraft?.damageNodeArray else {
//            return
//        }
//        let damageNodeArray = []
//        for damageNode in damageNodeArray {
//            addDamageNode(damageNode)
//        }
    }
    
    func addDamageNode(_ node: DamageNode) {
        guard let position = node.coordinates else  {
            return
        }
        
        let sphere = SCNSphere(radius: 0.1)
        let sphereNode = SCNNode(geometry: sphere)
        
        sphereNode.position = SCNVector3(position.x, position.y, position.z)
        sphereNode.geometry?.firstMaterial?.diffuse.contents = node.damageStatus.color
        sphereNode.accessibilityLabel = "damage"
        sphereNode.name = node.objectID.uriRepresentation().absoluteString
        
        sceneView.currentVirtualObject?.childNode(withName: node.node!, recursively: true)?.addChildNode(sphereNode)
    }
}
