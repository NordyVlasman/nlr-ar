//
//  ARManagerDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import Foundation

protocol ARManagerDelegate: class {
    func arShouldStopEditingModel()
    func arShouldStartEditingModel()
    func arShouldAddDamageNode(with node: DamageNode)
    func arShouldClearView(_ onFinish: (_ finished: Bool) -> ())
}
