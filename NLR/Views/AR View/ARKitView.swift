//
//  ARKitView.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import SwiftUI
import SceneKit
import ARKit

struct ARKitView: UIViewControllerRepresentable {
    @EnvironmentObject var arManager: ARManager
    @EnvironmentObject var appManager: AppManager
    
    var arViewController: ARViewController?

    func makeUIViewController(context: Context) -> ARViewController {
        let arViewController = ARViewController(arManager: arManager, appManager: appManager)
     
        return arViewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        uiViewController.arManager = arManager
        uiViewController.appManager = appManager
    }
}
