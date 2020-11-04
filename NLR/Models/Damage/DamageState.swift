//
//  State.swift
//  NLR
//
//  Created by Nordy Vlasman on 04/11/2020.
//

import Foundation
import UIKit
//@objc public enum DamageState: Int32, CaseIterable {
//    case Damage = 0
//    case Fixed  = 1
//}

public enum DamageState: Int32, CaseIterable {
    case Damage, Fixed
}

extension DamageState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Damage:
            return "Damage"
        case .Fixed:
            return "Fixed"
        }
    }
    
    public var color: UIColor {
        switch self {
        case .Damage:
            return UIColor(named: "Damage")!
        case .Fixed:
            return UIColor(named: "Fixed")!
        }
    }
}
