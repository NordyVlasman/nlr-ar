//
//  ARViewController.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/2/20.
//

import package_arbase
import UIKit
import SceneKit

class ARViewController: UIViewController {
    var arManager: ARManager
    var appManager: AppManager
    
    let sceneView = ARBaseView()
    let loader = ARBaseVirtualObjectLoader()
    let debugOptions: ARBaseDebugOptions = []
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    let referenceNode = SCNReferenceNode(named: "Art.scnassets/fullsize/fullsize.scn")!
    
    var currentVirtualObjectEditing: ARBaseVirtualObject?
    
    init(arManager: ARManager, appManager: AppManager) {
        self.arManager = arManager
        self.appManager = appManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Missing some essential imports")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arManager.delegate = self
        appManager.delegate = self
        
        sceneView.placingMode = .quickDrop
        sceneView.arBaseDelegate = self
        sceneView.isAutoFocusEnabled = false
        sceneView.isLightingIntensityAutomaticallyUpdated = true
        sceneView.environmentTexturing = .automatic
        sceneView.lightingEnvironmentContent = nil
        sceneView.baseLightingEnvironmentIntensity = 6
        
        sceneView.initialPreviewObjectOpacity = 0.667
        sceneView.initialPreviewObjectMaxSizeRatio = CGSize(width: 0.667, height: 0.667)
        sceneView.allowedGestureTypes = [.tap, .pan, .rotation, .pinch, .longPress]
        
        self.view.addSubview(sceneView)
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeARBase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeARModel()
    }
    
    //MARK: - Scene initialization
    private func initializeARBase() {
        UIApplication.shared.isIdleTimerDisabled = true
        sceneView.startAR()
    }
    
    private func initializeARModel() {
        let virtualObject = ARBaseVirtualObject(refferenceNode: referenceNode, allowedAlignments: [.horizontal])
        
        loader.loadVirtualObject(virtualObject) { loadedObject in
            loadedObject.defaultScale = 0.004
            
            self.sceneView.currentVirtualObject = loadedObject
            self.sceneView.currentVirtualObject?.contentNode?.opacity = 0
            
            SceneKitAnimator.animateWithDuration(duration: 0.35, animations: {
                self.sceneView.currentVirtualObject?.contentNode?.opacity = 1
            })
        }
    }
    
    //MARK: - View initialization
    private func setupViews() {
        setupSceneView()
    }
    
    private func setupSceneView() {
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
