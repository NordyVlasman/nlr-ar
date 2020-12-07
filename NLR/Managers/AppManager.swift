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
        guard let delegate = delegate else { return }
        isEditingModel = true
        delegate.arShouldStartEditing()
    }
    
    func stopEditingModel() {
        guard let delegate = delegate else { return }
        isEditingModel = false
        delegate.arShouldFinishEditing()
    }
}
