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
    @EnvironmentObject var manager: ARManager

    var arViewController: ARViewController?

    func makeUIViewController(context: Context) -> ARViewController {
        let arViewController = ARViewController(arManager: manager)
        
        return arViewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        uiViewController.manager = manager
    }
}
