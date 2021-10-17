//
//  ViewController.swift
//  PlantDiseases
//
//  Created by Apple on 2021/10/14.
//

import UIKit
import AVKit
import CoreML
import Vision

let screenWidth = UIScreen.main.bounds.width

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let upload: BtnPleinLarge = {
        let button = BtnPleinLarge(with: IconTextButtonViewModel( text: "Upload an image",
                                                                  image: UIImage(named: "upload"),
                                                                  backgroundColor: UIColor.uploadBtnColor,
                                                                  borderColor: UIColor.uploadBtnColor.cgColor))
        button.addTarget(self, action: #selector(buttonToUpload(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let openCamera: BtnPleinLarge = {
        let button = BtnPleinLarge(with: IconTextButtonViewModel( text: "Take a picture",
                                                                  image: UIImage(named: "camera"),
                                                                  backgroundColor: UIColor.openCameraBtnColor,
                                                                  borderColor: UIColor.openCameraBtnColor.cgColor))
        button.addTarget(self, action: #selector(buttonToOpenCamera(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .white
        
        addSubviews()
        setupLayout()
        
    }
    
    func addSubviews() {
        view.addSubview(upload)
        view.addSubview(openCamera)
    }
    
    func setupLayout() {
        upload.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        upload.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        upload.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        upload.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        openCamera.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openCamera.topAnchor.constraint(equalTo: upload.bottomAnchor, constant: 30).isActive = true
        openCamera.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        openCamera.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let model = try? VNCoreMLModel(for: ClassifierModel(configuration: MLModelConfiguration()).model) else {
                fatalError("Unable to load model")
            }
            
            let request = VNCoreMLRequest(model: model) {[weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation],
                      let topResult = results.first, let prediction = results.first?.confidence
                    else {
                        fatalError("Unexpected results")
                }
                let predconfidence = String(format: "%.02f%", prediction * 100)
                print("Top Result: \(topResult) and \(prediction) and \(topResult.identifier)")
                
                // Update the main UI thread with our result
                DispatchQueue.main.async {[weak self] in
                    let controller = ResultShowViewController()
                    controller.uploadImage.image = pickedImage
                    controller.result.text = topResult.identifier
                    controller.accuracy.text = predconfidence + "%"
                    controller.modalPresentationStyle = .fullScreen
                    self?.present(controller, animated: true)
                }
            }
            
            guard let ciImage = CIImage(image: pickedImage)
                else { fatalError("Cannot read picked image")}
            
            // Run the classifier
            let handler = VNImageRequestHandler(ciImage: ciImage)
            DispatchQueue.global().async {
                do {
                    try handler.perform([request])
                } catch {
                    print(error)
                }
            }
        }
        
    }
    
    @objc func buttonToUpload(_ sender: BtnPleinLarge) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func buttonToOpenCamera(_ sender: BtnPleinLarge) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

}
            

