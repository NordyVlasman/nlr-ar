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
    // Adds the already submited damages to the AR Model.
    func prepareObject() {
        guard let damageNodeArray = arManager.currentSession?.damageNodeArray else {
            return
        }
        for damageNode in damageNodeArray {
            addDamageNode(damageNode)
        }
    }

    // Create the DameNode and place it on the placed model.
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

        currentVirtualObjectEditing?.childNode(withName: node.node!, recursively: true)?.addChildNode(sphereNode)
    }
}
