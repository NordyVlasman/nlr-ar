//
//  ARViewController+ViewSetup.swift
//  NLR
//
//  Created by Nordy Vlasman on 02/11/2020.
//

import Foundation
import UIKit

extension ARViewController {
    func setupView() {
        setupSceneView()
        setupPlaceVirtualObjectButton()
        setupAddIssueButton()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupSceneView() {
        view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAddIssueButton() {
        sceneView.addSubview(addIssueButton)
        
        addIssueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addIssueButton.topAnchor.constraint(equalTo: sceneView.topAnchor, constant: +25),
            addIssueButton.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -20),
            addIssueButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        addIssueButton.addTarget(self, action: #selector(addTapReportAction(sender:)), for: .touchUpInside)
        addIssueButton.setTitle("Issues toevoegen", for: .normal)
    }
    
    func setupPlaceVirtualObjectButton() {
        sceneView.addSubview(placeVirtualObjectButton)
        
        placeVirtualObjectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeVirtualObjectButton.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor),
            placeVirtualObjectButton.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -30),
            placeVirtualObjectButton.heightAnchor.constraint(equalToConstant: 55),
            placeVirtualObjectButton.widthAnchor.constraint(equalTo: placeVirtualObjectButton.heightAnchor)
        ])
        
        placeVirtualObjectButton.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        placeVirtualObjectButton.addTarget(self, action: #selector(placeVirtualObject(sender:)), for: .touchUpInside)
        
        placeVirtualObjectButton.tintColor = .white
    }
}
