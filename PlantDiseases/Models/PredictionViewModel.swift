//
//  PredictionViewModel.swift
//  PlantDiseases
//
//  Created by Apple on 2021/10/14.
//

import Foundation
import UIKit
import CoreML
import Vision

typealias ResultCallback = (String) -> Void

enum ImageType {
    case ciimage(img: CIImage)
    case pixels(buffer: CVPixelBuffer)
}

class PredictionViewModel: NSObject {

    func predictImage(_ image: ImageType, callback: @escaping ResultCallback) {
       
        guard let model = self.getCoreMLModel() else {
            print("Coundn't get the model")
            callback("Coundn't get the model")
            return
        }
        
        self.requestPrediction(model: model, predictImage: image) { (predictionMessage) in
            callback(predictionMessage)
        }
    }
    
    // MARK: - Private methods
    
    private func getCoreMLModel() -> VNCoreMLModel? {
        
        guard let model = try? VNCoreMLModel(for: ClassifierModel(configuration: MLModelConfiguration()).model) else {
            return nil
        }
       
        
        return model
    }
    
    private func requestPrediction(model: VNCoreMLModel, predictImage: ImageType, callback: @escaping ResultCallback) {
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    print("Unexpected result type form VNCoreMLRequest")
                    callback("Prediction Error")
                    return
            }
            
            let result = topResult.identifier
            callback(result)
        }
        
        requestHandler(request: request, imageToPredict: predictImage)
    }
    
    private func requestHandler(request: VNCoreMLRequest, imageToPredict: ImageType) {
        
        let handler: VNImageRequestHandler
        
        switch imageToPredict {
        case .ciimage(let img):
            handler = VNImageRequestHandler(ciImage: img)
        case .pixels(let buffer):
            handler = VNImageRequestHandler(cvPixelBuffer: buffer, options: [:])
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}
