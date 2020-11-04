//
//  State.swift
//  NLR
//
//  Created by Nordy Vlasman on 04/11/2020.
//

import Foundation
import UIKit

public enum DamageState: Int32, CaseIterable {
    case Damage, Fixed, Checked, Problem
}

extension DamageState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Damage:
            return "Damage"
        case .Checked:
            return "Checked"
        case .Fixed:
            return "Fixed"
        case .Problem:
            return "Problem"
        }
    }
    
    public var color: UIColor {
        switch self {
        case .Damage:
            return UIColor(named: "Damage")!
        case .Fixed:
            return UIColor(named: "Fixed")!
        case .Checked:
            return UIColor(named: "Checked")!
        case .Problem:
            return UIColor(named: "Problem")!
        }
    }
}
