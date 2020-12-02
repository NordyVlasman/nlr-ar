//
//  ARViewController+AppManagerDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/2/20.
//

import Foundation

extension ARViewController: AppManagerDelegate {
    func arShouldStartEditing() {
        guard let object = sceneView.currentVirtualObject else { return }
        object.setIsEditing(edit: true)
        generator.impactOccurred()
        
        SceneKitAnimator.animateWithDuration(duration: 0.35, animations: {
            self.sceneView.currentVirtualObject?.contentNode?.opacity = 0.9
        })
    }
    
    func arShouldFinishEditing() {
        guard let object = sceneView.currentVirtualObject else { return }
        object.setIsEditing(edit: false)
        
        SceneKitAnimator.animateWithDuration(duration: 0.35, animations: {
            self.sceneView.currentVirtualObject?.contentNode?.opacity = 1
        })
        
        notificationFeedbackGenerator.notificationOccurred(.success)
    }
    
    
}
