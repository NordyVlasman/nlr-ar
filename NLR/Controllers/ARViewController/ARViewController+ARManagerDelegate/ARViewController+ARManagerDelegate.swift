//
//  ARViewController+ARManagerDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/2/20.
//

import Foundation

extension ARViewController: ARManagerDelegate {
    func arShouldClearView(_ onFinish: (Bool) -> ()) {
        sceneView.scene.rootNode.removeFromParentNode()
        sceneView.resetAR()
        onFinish(true)
    }
    
    func arShouldAddDamageNode(with node: DamageNode) {
        addDamageNode(node)
    }
    
    func arShouldStopEditingModel() {
        guard let object = currentVirtualObjectEditing else { return }
        object.setIsEditing(edit: false)

        SceneKitAnimator.animateWithDuration(duration: 0.35, animations: {
            object.contentNode?.opacity = 1
        })

        FeedbackGenerator.shared.triggerSelection()
    }
    
    func arShouldStartEditingModel() {
        guard let object = sceneView.currentVirtualObject else { return }
        currentVirtualObjectEditing = object
        object.setIsEditing(edit: true)
       
        FeedbackGenerator.shared.triggerSelection()

        SceneKitAnimator.animateWithDuration(duration: 0.35, animations: {
            self.sceneView.currentVirtualObject?.contentNode?.opacity = 0.9
        })
    }
}
