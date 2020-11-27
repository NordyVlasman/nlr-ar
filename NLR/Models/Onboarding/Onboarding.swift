//
//  Onboarding.swift
//  NLR
//
//  Created by Nordy Vlasman on 05/11/2020.
//

import Foundation

struct Onboarding {
    var image: String
    var title: String
    var description: String
}

extension Onboarding {
    static var data: [Onboarding] = [
        Onboarding(image: "screen-1", title: "Fast selection", description: "Fill in the Tail number and get started!"),
        Onboarding(image: "screen-2", title: "Color status", description: "Damage finished, let's go green!"),
        Onboarding(image: "screen-3", title: "Precise indication", description: "Know the exact location of the issue on the plane"),
        Onboarding(image: "screen-4", title: "Let it go", description: "Let your collague check the issue after fixing it"),
        Onboarding(image: "screen-5", title: "Camera", description: "We need your camera to work in Augmented Reality")
    ]
}
