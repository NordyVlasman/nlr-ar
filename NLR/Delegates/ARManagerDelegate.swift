//
//  ARManagerDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import Foundation

protocol ARManagerDelegate: class {
    func arExperienceShouldStart()
    func setupCoachingOverlay()
    func arExperienceShouldPause()
}
