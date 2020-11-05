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
        Onboarding(image: "onboarding-first", title: "First", description: "Description"),
        Onboarding(image: "onboarding-first", title: "Second", description: "Description"),
        Onboarding(image: "onboarding-first", title: "Third", description: "Description"),
    ]
}
