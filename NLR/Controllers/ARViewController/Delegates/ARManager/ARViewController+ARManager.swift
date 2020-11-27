//
//  ARViewController+ARManager.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//
import SceneKit

extension ARViewController: ARManagerDelegate {
    func arExperienceShouldStart() {
        placeVirtualObjectButton.isEnabled = false
        self.restartExperience()
    }
    
    func arExperienceShouldPause() {
        session.pause()
    }
    
    func arShouldAddDamageNode(with node: DamageNode) {
        guard let position = node.coordinates else { return }
        let sphere = SCNSphere(radius: 0.1)
        let sphereNode = SCNNode(geometry: sphere)
        
        sphereNode.position = SCNVector3(position.x, position.y, position.z)
        sphereNode.geometry?.firstMaterial?.diffuse.contents = node.damageStatus.color
        sphereNode.accessibilityLabel = "damage"
        sphereNode.name = node.objectID.uriRepresentation().absoluteString
        placedObject?.childNode(withName: node.node!, recursively: true)?.addChildNode(sphereNode)
    }
    
    func arShouldPlaceObject() {
        self.placeVirtualObject(sender: self)
    }
    
    func undoDamageNode() {
        
    }
}
