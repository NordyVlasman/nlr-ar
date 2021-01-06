//
//  ARViewController.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/2/20.
//

import package_arbase
import UIKit
import SceneKit
import MediaPlayer

class ARViewController: UIViewController {
    var arManager: ARManager
    var appManager: AppManager

    let sceneView = ARBaseView()
    let loader = ARBaseVirtualObjectLoader()
    let debugOptions: ARBaseDebugOptions = []
    let referenceNode = SCNReferenceNode(named: "Art.scnassets/fullsize/fullsize.scn")!

    var currentVirtualObjectEditing: ARBaseVirtualObject?

    override var prefersStatusBarHidden: Bool {
        return true
    }

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

        let volumeChangedSystemName = NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged), name: volumeChangedSystemName, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeARBase()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeARModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sceneView.pause(self)
        super.viewWillDisappear(animated)
    }
    
    // Small hacky feature to use the volume up for adding a damageNode
    @objc private func volumeChanged(notification: NSNotification) {
        guard
            let info = notification.userInfo,
            let reason = info["AVSystemController_AudioVolumeChangeReasonNotificationParameter"] as? String,
            reason == "ExplicitVolumeChange" else { return }

        guard let virtualObject = currentVirtualObjectEditing else { return }

        let hitNode = sceneView.hitTest(sceneView.center).first
        virtualObject.enumerateChildNodes { (node, _) in
            if hitNode?.node == node {
                
//                arManager.addDamageNode(location: hitNode!.localCoordinates, node: hitNode!.node.name!)
            }
        }
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

        let volumeView = MPVolumeView(frame: CGRect(x: -CGFloat.greatestFiniteMagnitude, y: 0, width: 0, height: 0))
        view.addSubview(volumeView)
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
