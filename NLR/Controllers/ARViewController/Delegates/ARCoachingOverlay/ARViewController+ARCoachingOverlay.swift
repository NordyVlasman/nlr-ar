//
//  ARViewController+ARCoachingOverlay.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import ARKit

extension ARViewController: ARCoachingOverlayViewDelegate {
    var coachingOverlay: ARCoachingOverlayView {
        coachingOverlayView
    }
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        restartExperience()
    }

    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        manager.shouldShowFocusSquare = true
    }
    
    func setupCoachingOverlay() {
        coachingOverlay.session = sceneView.session
        coachingOverlay.delegate = self
        
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(coachingOverlayView)
        
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: sceneView.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: sceneView.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: sceneView.heightAnchor)
        ])
        
        setActivatesAutomatically()
        setGoal()
    }
    
    /// - Tag: CoachingActivatesAutomatically
    func setActivatesAutomatically() {
        coachingOverlayView.activatesAutomatically = true
    }

    /// - Tag: CoachingGoal
    func setGoal() {
        coachingOverlayView.goal = .horizontalPlane
    }
    
    func updateFocusSquare() {
        if !manager.shouldShowFocusSquare || coachingOverlay.isActive {
            focusSquare.hide()
            return
        } else {
            focusSquare.unhide()
        }
        
        if let camera = session.currentFrame?.camera,
           case.normal = camera.trackingState,
           let query = sceneView.getRaycastQuery(),
           let result = sceneView.castRay(for: query).first {
            
            updateQueue.async { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
                self.focusSquare.state = .detecting(raycastResult: result, camera: camera)
            }
        } else {
            updateQueue.async { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.focusSquare.state = .initializing
                self.sceneView.pointOfView?.addChildNode(self.focusSquare)
            }
        }
    }
}
