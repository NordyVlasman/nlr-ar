//
//  ARViewController+ARSessionDelegate.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import Foundation
import ARKit

extension ARViewController: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard currentBuffer == nil, case .normal = frame.camera.trackingState else { return }
        currentBuffer = frame.capturedImage
        
        startDetection()
    }
    
    private func startDetection() {
        // To avoid force unwrap in VNImageRequestHandler
        guard let buffer = currentBuffer else { return }

        handDetector.performDetection(inputBuffer: buffer) { outputBuffer, thumbBuffer, _ in
            var normalizedFingerTip: CGPoint?

            defer {
                DispatchQueue.main.async {
                    self.currentBuffer = nil

                    guard let tipPoint = normalizedFingerTip else {
                        return
                    }
                    
                    let imageFingerPoint = VNImagePointForNormalizedPoint( tipPoint,
                                                                           Int(self.view.bounds.size.width),
                                                                           Int(self.view.bounds.size.height))

                    let hitTestResults = self.sceneView.raycastQuery(from: imageFingerPoint, allowing: .estimatedPlane, alignment: .vertical)
                    
                    guard let translation = hitTestResults?.direction else {return}
                    let sphere = SCNSphere(radius: 0.01)
                    let sphereNode = SCNNode(geometry: sphere)
                    sphereNode.position = SCNVector3(translation.x, translation.y, translation.z)
                    sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                    sphereNode.accessibilityLabel = "damage"
                    
                    self.sceneView.scene.rootNode.addChildNode(sphereNode)
                }
            }

            guard let outBuffer = outputBuffer else {
                return
            }
            
            guard let observations = thumbBuffer else { return }
            
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
                print("\(topPredictionName) = \(score)")
                if (score != nil && score! > 0.6) {
                    if (topPredictionName == "👍") {
                        self.manager.thumbUp()
                    } else {
                        self.manager.thumbDown()
                    }
                }
                
                self.latestPrediction = topPredictionName
            }
            
            normalizedFingerTip = outBuffer.searchTopPoint()
           
        }
        
        
    }
}
