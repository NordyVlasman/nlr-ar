//
//  AppManager.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import Foundation

class AppManager: ObservableObject {
    
    @Published var flowFinished: Bool = false
    @Published var isEditingModel: Bool = false

    weak var delegate: AppManagerDelegate?

    func startEditingModel() {
        isEditingModel = true
        delegate?.arShouldStartEditing()
    }
    
    func stopEditingModel() {
        isEditingModel = false
        delegate?.arShouldFinishEditing()
    }
}
