//
//  AircraftPreview.swift
//  NLR
//
//  Created by Nordy Vlasman on 03/11/2020.
//

import SwiftUI
import SceneKit

struct AircraftPreview: UIViewRepresentable {
    
    var problems: [DamageNode]
    
    func makeUIView(context: Context) -> SummaryPreviewView {
        let previewView = SummaryPreviewView(problems: problems)
        previewView.backgroundColor = .clear
        previewView.sceneView.backgroundColor = UIColor(white: 0,
                                                        alpha: 0)
        return previewView
    }
    
    func updateUIView(_ uiView: SummaryPreviewView, context: Context) {
        //
    }
    
}

class SummaryPreviewView: UIView {
    
    var sceneView: SCNView
    var cameraControlNode: SCNNode!
    var contentNode: SCNNode!
    var scene: SCNScene!
    
    var problems: [DamageNode]
    
    
    init(problems: [DamageNode]) {
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
        
        nodeToPlace.scale = SCNVector3(0.3, 0.3, 0.3)
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
        for damageNode in problems {
            addDamageNode(damageNode)
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

//MARK: - SceneKit animator
public extension CAMediaTimingFunction {
    
    static let linear = CAMediaTimingFunction(controlPoints: 0, 0, 1, 1)
    
    static let easeIn = CAMediaTimingFunction(controlPoints: 0.9, 0, 0.9, 1)
    
    static let easeOut = CAMediaTimingFunction(controlPoints: 0.1, 0, 0.1, 1)
    
    static let easeInOut = CAMediaTimingFunction(controlPoints: 0.45, 0, 0.55, 1)
    
    static let easeInEaseOut = CAMediaTimingFunction(controlPoints: 0.42, 0, 0.58, 1)
    
    static let explodingEaseOut = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)
    
    static let `default` = CAMediaTimingFunction(controlPoints: 0, 0, 0.2, 1)
    
}

public class SceneKitAnimator {
    
    var completed: (() -> Void)?
    
    @discardableResult
    /// A block object wrapping animations and combining scene graph changes into atomic updates.
    ///
    /// - Parameters:
    ///   - duration: The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them.
    ///   - timingFunction: A function that defines the pacing of an animation as a timing curve.
    ///   - animated: A boolean value that determines if this animation expected to perform or not. The defualt value of this property is true.
    ///   - animations: A block object containing the changes to commit to the views. This is where you programmatically change any animatable properties of the views in your view hierarchy. This block takes no parameters and has no return value. This parameter must not be NULL.
    ///   - completion: A block object to be executed when the animation sequence ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. If the duration of the animation is 0, this block is performed at the beginning of the next run loop cycle. This parameter may be NULL.
    /// - Returns: The object wrapping SceneKit animation.
    public class func animateWithDuration(duration: TimeInterval,
                                          timingFunction: CAMediaTimingFunction = .default,
                                          animated: Bool = true,
                                          animations: (() -> Void),
                                          completion: (() -> Void)? = nil) -> SceneKitAnimator{
        let promise = SceneKitAnimator()
        SCNTransaction.begin()
        SCNTransaction.completionBlock = { [weak promise] in
            completion?()
            promise?.completed?()
            
        }
        SCNTransaction.animationTimingFunction = timingFunction
        SCNTransaction.animationDuration = duration
        animations()
        SCNTransaction.commit()
        return promise
    }
    
    @discardableResult
    /// A block object wrapping animations and combining scene graph changes into atomic updates.
    ///
    /// - Parameters:
    ///   - duration: The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them.
    ///   - timingFunction: A function that defines the pacing of an animation as a timing curve.
    ///   - animated: A boolean value that determines if this animation expected to perform or not. The defualt value of this property is true.
    ///   - animations: A block object containing the changes to commit to the views. This is where you programmatically change any animatable properties of the views in your view hierarchy. This block takes no parameters and has no return value. This parameter must not be NULL.
    ///   - completion: A block object to be executed when the animation sequence ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. If the duration of the animation is 0, this block is performed at the beginning of the next run loop cycle. This parameter may be NULL.
    /// - Returns: The object wrapping SceneKit animation.
    public func thenAnimateWithDuration(duration: TimeInterval,
                                        timingFunction: CAMediaTimingFunction = .default,
                                        animated: Bool = true,
                                        animations: @escaping (() -> Void),
                                        completion: (() -> Void)? = nil) -> SceneKitAnimator {
        let animator = SceneKitAnimator()
        completed = { [weak animator] in
            SceneKitAnimator.animateWithDuration(duration: duration,
                                                 timingFunction: timingFunction,
                                                 animated: animated,
                                                 animations: animations,
                                                 completion: {
                                                    animator?.completed?()
                                                    completion?()
            })
        }
        return animator
    }
    
}

//MARK: - tilt mode

class TiltNodeMotionEffect: UIMotionEffect {
    
    private var basedEulerAngles = SCNVector3Zero
    private var basedPosition = SCNVector3Zero
    
    /// `SCNNode` that will be tilted or reposition based on visual effect
    weak var node: SCNNode?
    
    /// Intensity of vertical tilt
    var verticalTiltedIntensity: CGFloat = 1 / 4
    
    /// Intensity of horizontal tilt
    var horizontalTiltedIntensity: CGFloat = 1 / 24
    
    /// Intensity of vertical shift
    var verticalShiftedIntensity: CGFloat = 0
    
    /// Intensity of horizontal shift
    var horizontalShiftedIntensity: CGFloat = 1 / 2
    
    /// Add motion effect to `SCNNode`
    ///
    /// - Parameter node: `SCNNode` that will be tilted or reposition based on visual effect
    init(node: SCNNode) {
        super.init()
        self.node = node // Set value at init
        basedPosition = node.position
        basedEulerAngles = node.eulerAngles
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func keyPathsAndRelativeValues(forViewerOffset viewerOffset: UIOffset) -> [String : Any]? {

        // Shifting position
        node?.position = SCNVector3Make(
            basedPosition.x + Float(viewerOffset.horizontal * horizontalShiftedIntensity),
            basedPosition.y - Float(viewerOffset.vertical * verticalShiftedIntensity),
            basedPosition.z )
 
        // Tilting Angle
        node?.eulerAngles = SCNVector3Make(basedEulerAngles.x + Float(viewerOffset.vertical * verticalTiltedIntensity), basedEulerAngles.y + Float(viewerOffset.horizontal * horizontalTiltedIntensity), basedEulerAngles.z)
        return nil
    }
}
