//
//  HandDetector.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/19/20.
//

import CoreML
import Vision

public class HandDetector {
    
    private let visionQueue = DispatchQueue(label: "io.nlr.nlrar-handtracking")
    private lazy var predictionRequest: VNCoreMLRequest = {
        // Load the ML model through its generated class and create a Vision request for it.
        do {
            let model = try VNCoreMLModel(for: HandModel().model)
            let request = VNCoreMLRequest(model: model)

            // This setting determines if images are scaled or cropped to fit our 224x224 input size. Here we try scaleFill so we don't cut part of the image.
            request.imageCropAndScaleOption = VNImageCropAndScaleOption.scaleFill
            
            return request
        } catch {
            fatalError("can't load Vision ML model: \(error)")
        }
    }()
    
    private lazy var thumbRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: ThumbClassifier().model)
            let request = VNCoreMLRequest(model: model)
            
            request.imageCropAndScaleOption = VNImageCropAndScaleOption.scaleFill
            return request
        } catch {
            fatalError("Hello world")
        }
    }()
    
    
    // MARK: - Public functions
    public func performDetection(inputBuffer: CVPixelBuffer, completion: @escaping (_ outputBuffer: CVPixelBuffer?, _ outputThumbBuffer: [Any]?, _ error: Error?) -> Void) {
        // Right orientation because the pixel data for image captured by an iOS device is encoded in the camera sensor's native landscape orientation
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: inputBuffer, orientation: .right)
        
        // We perform our CoreML Requests asynchronously.
        visionQueue.async {
            // Run our CoreML Request
            do {
                try requestHandler.perform([self.predictionRequest, self.thumbRequest])

                guard let observation = self.predictionRequest.results?.first as? VNPixelBufferObservation else {
                    fatalError("Unexpected result type from VNCoreMLRequest")
                }
                
                guard let result = self.thumbRequest.results else {return }
                
                // The resulting image (mask) is available as observation.pixelBuffer
                completion(observation.pixelBuffer, result, nil)
            } catch {
                completion(nil, nil, error)
            }
        }
    }
}

