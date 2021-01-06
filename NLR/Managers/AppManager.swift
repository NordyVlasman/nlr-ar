//
//  AppManager.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import Foundation

class AppManager: ObservableObject {
    public static let shared = AppManager()

    @Published var flowFinished: Bool = false
    @Published var isEditingModel: Bool = false


    func startEditingModel() {
        isEditingModel = true
    }
    
    func stopEditingModel() {
        isEditingModel = false
    }
}
