//
//  AircraftPreview.swift
//  NLR
//
//  Created by Nordy Vlasman on 03/11/2020.
//

import SwiftUI
import SceneKit

struct AircraftPreview: UIViewRepresentable {
    
    var problems: [DamageNode]?
    
    func makeUIView(context: Context) -> SummaryPreviewView {
        let previewView = SummaryPreviewView(problems: problems)
        previewView.backgroundColor = .clear
        previewView.sceneView.backgroundColor = UIColor(white: 0,
                                                        alpha: 0)
        return previewView
    }
    
    func updateUIView(_ uiView: SummaryPreviewView, context: Context) { }
    
}

class SummaryPreviewView: UIView {
    
    var sceneView: SCNView
    var cameraControlNode: SCNNode!
    var contentNode: SCNNode!
    var scene: SCNScene!
    
    var problems: [DamageNode]?
    
    
    init(problems: [DamageNode]?) {
        self.problems = problems
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3), options: [:])
        super.init(frame: .zero)
        backgroundColor = .clear
        setupView()
        setupGesture()
        setupScene()
        setupCamera()
        setupContent()
        prepareObject()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(sceneView)
        sceneView.antialiasingMode = UIScreen.main.scale > 2 ? .multisampling2X : .multisampling4X
    }
    
    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureDidPan(_:)))
        addGestureRecognizer(panGesture)
    }
    
    private func setupScene() {
        scene = SCNScene()
        sceneView.scene = scene
        
        contentNode = SCNNode()
        scene.rootNode.addChildNode(contentNode)
        scene.background.contents = UIColor(white: 0,
                                            alpha: 0)
    }
    
    private func setupCamera() {
        cameraControlNode = SCNNode()
        cameraControlNode.position.y = 0.75
        
        let camera = SCNCamera()
        camera.fieldOfView = 18
        camera.projectionDirection = .vertical
        camera.motionBlurIntensity = 0.5
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position.z = 9
        cameraNode.position.y = 0.25
        cameraNode.look(at: SCNVector3Zero)
        
        cameraControlNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(cameraControlNode)
    }
    
    public func setupContent() {        
        guard let sceneView = SCNScene(named: "Art.scnassets/fullsize/fullsize.scn") else { return }
        let nodeToPlace = sceneView.rootNode
        
        nodeToPlace.scale = SCNVector3(6, 6, 6)
        nodeToPlace.position = SCNVector3(0, 0.5, 0)
        nodeToPlace.eulerAngles = SCNVector3(0, -Float.pi / 6, 0)

        contentNode.addChildNode(nodeToPlace)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let cameraControlNode = cameraControlNode {
            let tiltNodeMotionEffect = TiltNodeMotionEffect(node: cameraControlNode)
            
            tiltNodeMotionEffect.horizontalShiftedIntensity = 0
            tiltNodeMotionEffect.verticalShiftedIntensity = 0
            
            tiltNodeMotionEffect.horizontalTiltedIntensity = 1 / 2
            tiltNodeMotionEffect.verticalTiltedIntensity = 1 / 2
            
            superview?.addMotionEffect(tiltNodeMotionEffect)
        }
        
        guard let scene = sceneView.scene else { return }
        sceneView.prepare([scene.rootNode]) { finished in
            DispatchQueue.main.async { [weak self] in
                self?.playInitialAnimation()
            }
        }
        
    }
    
    private func playInitialAnimation() {
        weak var contentNode = self.contentNode
        
        contentNode?.scale = SCNVector3(0.1, 0.1, 0.1)
        contentNode?.eulerAngles = SCNVector3(0, Float.pi * 1.5, 0)
        SceneKitAnimator.animateWithDuration(duration: 0.35 * 1.5,
                                             timingFunction: .explodingEaseOut,
                                             animations: {
                                                contentNode?.scale = SCNVector3(1.066, 1.066, 1.066)
                                                contentNode?.eulerAngles = SCNVector3(0, Float.pi * -0.066, 0)
                                             }, completion: {
                                                SceneKitAnimator.animateWithDuration(duration: 0.35 / 1.5,
                                                                                     timingFunction: CAMediaTimingFunction(controlPoints: 0.33, 0, 0.33, 1),
                                                                                     animations: {
                                                                                        contentNode?.scale = SCNVector3(1, 1, 1)
                                                                                        contentNode?.eulerAngles = SCNVector3(0, 0, 0)
                                                                                     })
                                             })
    }
    
    func prepareObject() {
        if problems != nil {
            for damageNode in problems! {
                addDamageNode(damageNode)
            }
        }
    }
    
    func addDamageNode(_ node: DamageNode) {
        guard let position = node.coordinates else  {
            return
        }
        
        let sphere = SCNSphere(radius: 0.1)
        let sphereNode = SCNNode(geometry: sphere)
        
        sphereNode.position = SCNVector3(position.x, position.y, position.z)
        sphereNode.geometry?.firstMaterial?.diffuse.contents = node.damageStatus.color
        sphereNode.accessibilityLabel = "damage"
        sphereNode.name = node.objectID.uriRepresentation().absoluteString
        
        contentNode.childNode(withName: node.node!, recursively: true)?.addChildNode(sphereNode)

    }
    
    @objc func panGestureDidPan(_ sender: UIPanGestureRecognizer) {
        let state = sender.state
        let translatePercentage = sender.translation(in: sender.view!).x / max(sender.view!.bounds.width, sender.view!.bounds.height)
        switch state {
        case .changed:
            contentNode.eulerAngles.y = Float(translatePercentage * .pi / 2)
        case .ended:
            let duration: TimeInterval = TimeInterval(abs(contentNode.eulerAngles.y) / .pi)
            SceneKitAnimator.animateWithDuration(duration: duration, animations: {
                contentNode.eulerAngles.y = 0
            })
        default:
            break
        }
    }
}
