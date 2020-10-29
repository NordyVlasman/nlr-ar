//
//  ARViewController+ARManager.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

extension ARViewController: ARManagerDelegate {
    func arExperienceShouldStart() {
        self.restartExperience()
    }
    
    func arExperienceShouldPause() {
        session.pause()
    }
}
