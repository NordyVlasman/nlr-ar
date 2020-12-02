//
//  ARViewController+ARBaseViewDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/2/20.
//

import Foundation
import package_arbase
import SceneKit

extension ARViewController: ARBaseDelegate {
    func arBaseViewDidLongPress(on virtualObject: ARBaseVirtualObject?) {
        sceneView.currentVirtualObject = virtualObject
        appManager.startEditingModel()
    }
    
    func arBaseViewDidTap(on virtualObject: ARBaseVirtualObject?, withHitTest hitTest: [SCNHitTestResult]?) {
        if virtualObject == nil { return }
        if virtualObject!.isEditing {
            return
        }
        
        let result = hitTest?.first
        let tappedNode = result?.node
        
        if tappedNode?.accessibilityLabel == "damage" {
            notificationFeedbackGenerator.notificationOccurred(.warning)
            arManager.showDamageDetails(id: tappedNode!.name!)
            return
        }
        
        virtualObject?.enumerateChildNodes { (node, _) in
            if tappedNode == node {
                arManager.addDamageNode(location: result!.localCoordinates, node: tappedNode!.name!)
            }
        }
    }
    
    func arBaseViewWillPlace(_ virtualObject: ARBaseVirtualObject, at transform: SCNMatrix4) {
        sceneView.currentVirtualObject = virtualObject
        prepareObject()
        notificationFeedbackGenerator.notificationOccurred(.success)
    }
}
