//
//  ARManager.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import SwiftUI
import SceneKit
import Foundation
import Combine

class ARManager: ObservableObject {
    @Published var objectToPlace: VirtualObject?
    @Published var shouldShowARView = false
    @Published var shouldShowARCheckView = false
    @Published var shouldShowDamageModal: Bool = true
    
    @Published var currentCoordinates: SCNVector3?
    @Published var currentAircraft: Aircraft?
    @Published var currentNodeName: String?
    @Published var currentDamageNode: DamageNode?
    
    //MARK: - Modal states
    @Published var showDamageDetails: Bool = false
    @Published var showAddDamage: Bool = false
    
    @Published var hasAddedDamage: Bool = false

    var shouldShowFocusSquare = false
    
    weak var delegate: ARManagerDelegate?
    
    let persistenceController = PersistenceController.shared
    let feedback = UINotificationFeedbackGenerator()
    
    private func downloadVirtualObject(completionHandler: (() -> Void)? = nil) {
        guard let scene = SCNScene(named: "Art.scnassets/fullsize/fullsize.scn") else { return }
        guard let objectToPlace = VirtualObject(from: scene) else { return }
        
        self.objectToPlace = objectToPlace
        
        completionHandler?()
    }
    
    func download() {
        shouldShowFocusSquare = false
        downloadVirtualObject { [weak self] in
            self?.shouldShowFocusSquare = true
        }
    }
    
    func start() {
        delegate?.arExperienceShouldStart()
    }
    
    func pauseAR() {
        delegate?.arExperienceShouldPause()
    }
    
    func didPressAdd() {
        delegate?.arShouldPlaceObject()
    }
    
    func submitAddingDamageNode(with damageNode: DamageNode) {
        //TODO: Reset state of some data
        hasAddedDamage = true
        delegate?.arShouldAddDamageNode(with: damageNode)
        shouldShowDamageModal = true
        feedback.notificationOccurred(.success)
    }
    
    func addDamageNode(location: SCNVector3, node: String) {
        currentCoordinates = location
        currentNodeName = node
        showAddDamage = true
        shouldShowDamageModal = false
    }
    
    func showDamageDetails(id: String) {
        if let objectIDUrl = URL(string: id) {
           let id =  persistenceController.container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: objectIDUrl)
            currentDamageNode = persistenceController.container.viewContext.object(with: id!) as? DamageNode
        }
        showDamageDetails = true
        shouldShowDamageModal = false
    }
    
    func hideDamageDetails() {
        shouldShowDamageModal = true
        showDamageDetails = false
    }
    
    func addedModel() {
        shouldShowFocusSquare = false
    }
    
    func finishARScreen() {
        shouldShowARCheckView = true
        shouldShowARView = false
    }
    
    func finish() {
        shouldShowARView = false
        shouldShowARCheckView = false
    }
    
    //MARK: - New UI

}

