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
//        setupFinishARButton()
////        setupPlaceVirtualObjectButton()
////        setupAddIssueButton()
        
//        setupAddVirtualObjectButton()
//        setupSaveSessionButton()
//        setupUndoButton()
//        setupFinishSessionButton()
        
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
    
    //MARK: - Old UI
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
    
    func setupFinishARButton() {
        sceneView.addSubview(finishARButton)
        
        finishARButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finishARButton.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor),
            finishARButton.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -30),
            finishARButton.heightAnchor.constraint(equalToConstant: 55),
            finishARButton.widthAnchor.constraint(equalTo: finishARButton.heightAnchor, constant: +5)
        ])
        
        finishARButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        finishARButton.addTarget(self, action: #selector(finishARView(sender:)), for: .touchUpInside)
        finishARButton.tintColor = .white
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
    
    
    //MARK: - New UI    
    func setupAddVirtualObjectButton() {
        sceneView.addSubview(addVirtualObjectButton)
        addVirtualObjectButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addVirtualObjectButton.centerXAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -40),
            addVirtualObjectButton.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -30),
            addVirtualObjectButton.heightAnchor.constraint(equalToConstant: 55),
            addVirtualObjectButton.widthAnchor.constraint(equalTo: addVirtualObjectButton.heightAnchor, constant: +5)
        ])
        
        let image = UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
        addVirtualObjectButton.setBackgroundImage(image, for: .normal)
    }
    
    func setupSaveSessionButton() {
        sceneView.addSubview(saveSessionButton)
        saveSessionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveSessionButton.centerXAnchor.constraint(equalTo: sceneView.leadingAnchor, constant: -40),
            saveSessionButton.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -30),
            saveSessionButton.heightAnchor.constraint(equalToConstant: 20),
            saveSessionButton.widthAnchor.constraint(equalTo: saveSessionButton.heightAnchor, constant: +5)
        ])
        
        saveSessionButton.setBackgroundImage(UIImage(systemName: "archivebox.fill"), for: .normal)
        saveSessionButton.tintColor = .gray
        saveSessionButton.backgroundColor = .white
    }
    
    func setupUndoButton() {
        sceneView.addSubview (undoButton)
        undoButton.translatesAutoresizingMaskIntoConstraints = false
        
        undoButton.setBackgroundImage(UIImage(systemName: "arrow.turn.down.left"), for: .normal)
        undoButton.tintColor = .gray
        undoButton.backgroundColor = .white
    }
    
    func setupFinishSessionButton() {
        sceneView.addSubview(finishSessionButton)
        finishSessionButton.translatesAutoresizingMaskIntoConstraints = false
        
        finishSessionButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        finishSessionButton.tintColor = .gray
        finishSessionButton.backgroundColor = .white
        
    }
}

extension UIColor {
    func imageWithColor(width: Int, height: Int) -> UIImage {
        let size = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
