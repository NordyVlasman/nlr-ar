//
//  ARViewController+AppManagerDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/2/20.
//

import Foundation

extension ARViewController: AppManagerDelegate {
    // Sets editings state of the AR model
    func arShouldStartEditing() {
        guard let object = sceneView.currentVirtualObject else { return }
        currentVirtualObjectEditing = object
        object.setIsEditing(edit: true)
        generator.impactOccurred()

        SceneKitAnimator.animateWithDuration(duration: 0.35, animations: {
            self.sceneView.currentVirtualObject?.contentNode?.opacity = 0.9
        })
    }

    // Resets editing state on the placed AR Model
    func arShouldFinishEditing() {
        guard let object = currentVirtualObjectEditing else { return }
        object.setIsEditing(edit: false)

        SceneKitAnimator.animateWithDuration(duration: 0.35, animations: {
            object.contentNode?.opacity = 1
        })

        notificationFeedbackGenerator.notificationOccurred(.success)
    }
}
