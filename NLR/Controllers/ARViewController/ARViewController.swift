//
//  ARViewController.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import Vision

class ARViewController: UIViewController {
    let sceneView: ARSCNView = ARSCNView()
    let coachingOverlayView = ARCoachingOverlayView()
    let placeVirtualObjectButton: UIButton = UIButton(type: .custom)
    let addIssueButton: UIButton = UIButton(type: .custom)
    let persistenceController = PersistenceController.shared
    let feedback = UINotificationFeedbackGenerator()
    
    // TODO: - Replace this with the right identifier.
    let updateQueue = DispatchQueue(label: "io.nlr.nlrar")

    var lastObjectAvailabilityUpdateTimestamp: TimeInterval?
    var isRestartAvailable = true
    var isRunning = false
    var isAddingIssues = false
    
    var manager: ARManager
    var focusSquare = FocusSquare()
    
    var placedObject: SCNNode?
    
    var session: ARSession {
        sceneView.session
    }
    
    //MARK: - Machine Learning
    var visionRequest = [VNRequest]()
    var dispatchQueueML = DispatchQueue(label: "io.nlr.nlrarml")
    var latestPrediction = ""
    
    var handPoseRequest = VNDetectHumanHandPoseRequest()
    var currentBuffer: CVPixelBuffer?
    
    let handDetector = HandDetector()
    
    init(arManager: ARManager) {
        self.manager = arManager
        super.init(nibName: nil, bundle: nil)
        
        manager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
//        setupML()
    }
    
    func setupML() {
        let config = MLModelConfiguration()
        
        guard let selectedModel = try? VNCoreMLModel(for: ThumbClassifier(configuration: config).model) else {
            fatalError("Cant find the right ML Class")
        }
        
        let classifictationModel = VNCoreMLRequest(model: selectedModel, completionHandler: classificationCompletionHandler)
        visionRequest = [classifictationModel]
        
        loopCoreMLUpdate()
    }
    
    func classificationCompletionHandler(request: VNRequest, error: Error?) {
        if error != nil { return }
        
        guard let observations = request.results else {
            return
        }
        
        let classifications = observations[0...1]
            .compactMap({
                $0 as? VNClassificationObservation
            })
            .map({ "\($0.identifier) \(String(format:" : %.2f", $0.confidence))" })
            .joined(separator: "\n")
        
        DispatchQueue.main.async {
            let topPrediction = classifications.components(separatedBy: "\n")[0]
            let topPredictionName = topPrediction.components(separatedBy: ":")[0].trimmingCharacters(in: .whitespaces)

            let score: Float? = Float(topPrediction.components(separatedBy: ":")[1].trimmingCharacters(in: .whitespaces))
            if (score != nil && score! > 0.9) {
                if (topPredictionName == "👍") {
                    self.manager.thumbUp()
                } else {
                    self.manager.thumbDown()
                }
            }
            
            self.latestPrediction = topPredictionName
        }
    }
    
    func updateCoreML() {
        let pixelBuff: CVPixelBuffer? = (sceneView.session.currentFrame?.capturedImage)
        if pixelBuff == nil {
            return
        }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuff!)
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        do {
            try handler.perform(visionRequest)
        } catch {
            print("Error \(error)")
        } 
    }
    
    func loopCoreMLUpdate() {
        dispatchQueueML.async {
            self.updateCoreML()
            self.loopCoreMLUpdate()
        }
    }
}
