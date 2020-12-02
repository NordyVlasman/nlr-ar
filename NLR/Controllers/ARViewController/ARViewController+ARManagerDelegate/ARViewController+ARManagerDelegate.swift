//
//  ARViewController+ARManagerDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/2/20.
//

import Foundation

extension ARViewController: ARManagerDelegate {
    func arShouldAddDamageNode(with node: DamageNode) {
        addDamageNode(node)
    }
}
