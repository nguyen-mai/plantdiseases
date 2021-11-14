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
        let button = BtnPleinLarge(with: IconTextButtonViewModel( text: "Upload an image".localized(),
                                                                  image: UIImage(named: "upload"),
                                                                  backgroundColor: UIColor.uploadBtnColor,
                                                                  borderColor: UIColor.uploadBtnColor.cgColor))
        button.addTarget(self, action: #selector(buttonToUpload(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let openCamera: BtnPleinLarge = {
        let button = BtnPleinLarge(with: IconTextButtonViewModel( text: "Take a picture".localized(),
                                                                  image: UIImage(named: "camera"),
                                                                  backgroundColor: UIColor.openCameraBtnColor,
                                                                  borderColor: UIColor.openCameraBtnColor.cgColor))
        button.addTarget(self, action: #selector(buttonToOpenCamera(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                
                var predictedResult = topResult.identifier
                var plantType: String = "None".localized()
                var type: String = "None".localized()
                var threatLevel: String  = "None".localized()
                var aboutTxt: String = "None".localized()
                var conditionTxt: String = "None".localized()
                var treatmentTxt: String = "None".localized()
                switch predictedResult {
                case "Apple___Apple_scab":
                    predictedResult = "Apple Scab".localized()
                    plantType = "Apple".localized()
                    type = "Fungus".localized()
                    threatLevel = "High"
                    aboutTxt = "On leaves, diseased spots are round, greenish-gray, slightly raised. The disease usually first appears on the underside of leaves, then spreads gradually. On the fruit, the disease is dark brown, raised like a scab and cracked, the fruit is distorted and falls prematurely.".localized()
                    conditionTxt = "Fungi usually attack on leaf blades, petioles, flowers and young fruit, rarely on young shoots.\nThe mycelium usually spreads through water droplets, wind and infects the stomata of young parts of leaves, flower stalks, and young fruit to develop and cause damage.".localized()
                    treatmentTxt = "After harvesting, it is necessary to cut down thoroughly and collect all tree remnants. \nThe disease is concentrated and burned to avoid spreading.\n Do not plant too thick to make garden lack of light; pruning, shaping for good growth, good ventilation, avoiding high humidity in the garden: Ridozeb 72WP , Manozeb 80WP(60-80 g/16 lít nước); Carbenda Supper 50SC(30 ml/16 lít nước); Top 70WP(15 g/16 lit nước); Lipman 80WP(60-80 g/16 lít nước)".localized()
                case "Apple___Black_rot":
                    predictedResult = "Black Rot".localized()
                    plantType = "Apple".localized()
                    type = "Fungus".localized()
                    threatLevel = "High".localized()
                    aboutTxt = "The first signs of this disease are small spots that appear on the upper surface of the leaves, which then develop into brown or yellow spots, resembling \"frog eyes.\" Initially, the infected area is brown and may not change color as it increases in size or may turn black.As the area of ​​decay increases, a series of concentric bands usually form. of the rotting area remains firm and has a leathery odor.In the end, the apple completely rots, withers".localized()
                    conditionTxt = "It will spread from leaf to fruit.".localized()
                    treatmentTxt = "Adequate and balanced fertilization of NPK helps plants grow well in the dry season, ventilates the garden in the rainy season, and avoids low humidity.\nSpray evenly wet foliage, fruit when the disease appears: Gekko 20SC(15-20 ml/16 lít nước), Ridozeb 72WP, Manozeb 80WP(60-80 g/16 lít nước), Carbenda Supper 50SC(30 ml/16 lít nước)".localized()
                case "Apple___Cedar_apple_rust":
                    predictedResult = "Cedar Apple Rust".localized()
                    plantType = "Apple".localized()
                    type = "Fungus".localized()
                    threatLevel = "High".localized()
                    aboutTxt = "A sign of rust is the presence of rust spots on the leaves of your plants. Even an apple can be deformed or spotty. Indicating that the host is carrying rust, they will sprout yellow-orange in the spring to send spores that will attack your apple tree.".localized()
                    conditionTxt = "It will spread from leaf to fruit."
                    treatmentTxt = "To prevent rust, remove host plants. Also grow the following rust resistant apple varieties: Apple Redfree, Apples William's Pride, Apple Freedom"
                case "Apple___healthy", "Blueberry___healthy", "Cherry_(including_sour)___healthy", "Corn_(maize)___healthy", "Grape___healthy", "Peach___healthy", "Pepper,_bell___healthy", "Potato___healthy", "Raspberry___healthy", "Soybean___healthy", "Strawberry___healthy", "Tomato___healthy":
                    predictedResult = "Healthy".localized()
                case "Cherry_(including_sour)___Powdery_mildew":
                    predictedResult = "Cherry Powdery Mildew".localized()
                    plantType = "Cherry"
                    type = "Fungus".localized()
                    threatLevel = "High".localized()
                case "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot":
                    predictedResult = "Corn Grey Leaf Spot".localized()
                    plantType = "Corn".localized()
                    type = "Fungus".localized()
                    threatLevel = "High".localized()
                    aboutTxt = "Initially, the lesions are only as small as needles, yellowish in color, then gradually develop into round, oval or amorphous shapes, the color and size of the lesions change. The disease occurs in all parts of the maize plant: leaves, stems, corn but mainly on leaves. The disease can arise very early as soon as the corn plant has 2-3 leaves.".localized()
                    conditionTxt = "The disease arises in humid climates, fungal spores form a lot, especially in the stem nodes, leaf blades, corn husks forming a brown or black hairy layer. Leaf spot disease often causes a lot of damage in bad corn fields are fields without intensive farming, making the plants stunted and ugly. In addition, bad soils, lowland or waterlogged soils, fields with heavy, tight meat texture, or fields with frequent water shortages... make maize plants grow poorly, stunted, and unable to develop.".localized()
                    treatmentTxt = "Corn should be planted in fields with light soil or sandy soil, with a good irrigation system, ensuring drainage in the rainy season and having enough water to actively irrigate corn in the dry season, creating growth for maize. and favorable development.\nCollect cleanly the remnants of diseased corn plants after harvest… Before planting, it is necessary to plow and harrow the field thoroughly to bury the remnants of diseased plants to kill the source of the disease spreading to the next crop.\nCare, fertilize and water properly to prevent diseases.\nWhen the field is sick, use one of the drugs such as: Tilt super 300EC; Daconil; Ridomil; Validacin; Mannozeb 80WP…for spraying. Before spraying, carefully read the instructions on how to use the drug printed on the packaging.\nIf the field is often seriously damaged by diseases, it should be rotated with some other vegetables to limit and prevent diseases.".localized()
                case "Corn_(maize)___Common_rust_":
                    predictedResult = "Common Rust".localized()
                    plantType = "Corn".localized()
                    type = "Fungus".localized()
                    threatLevel = "High".localized()
                    aboutTxt = "Initially clear to pale yellow dots, scattered on the leaf blade. After creating floating tumors, causing the cells to crack, the inside contains a yellow-brown powder, yellow brick when young. At the end of the growth stage, the disease develops a lot, covers the leaves, black spots form long black spots on the leaf blade.".localized()
                    conditionTxt = "The disease exists on the remnants of diseased leaves, seeds, and corn. The suitable temperature for disease development is 17-18°C. Inadequately cared for fields, plants grow poorly, diseases arise early, cause severe damage, leaves dry, die early, yield is reduced by 20%. The fungus retains the following crop mainly by spores on maize residues and seeds.\nThe disease appears more in the flowering stage.".localized()
                    treatmentTxt = "Sanitize the field, destroy the source of disease. Intensification of farming.\nUse fungicides: New Kasuran; Dithane; Anvil; Kumulus; Cavil; Tilvil; Vectra; Copper-zinc C…".localized()
                case "Corn_(maize)___Northern_Leaf_Blight":
                    predictedResult = "Northern Corn Leaf Blight".localized()
                    plantType = "Corn".localized()
                    type = "Fungus".localized()
                    threatLevel = "High".localized()
                    aboutTxt = "The lesions are long and round or oval, brown or silver-gray, without a yellow halo. If the disease is severe, many spots will mix together, making the whole leaf dry. Leaves lose color, wither and become brittle.".localized()
                    conditionTxt = "Large leaf spot disease often occurs in bad, underdeveloped corn fields; bad fields, lowland or waterlogged soil, fields with heavy texture, tight, easy to scum, or fields that are often lack of water… making corn plants grow poorly, stunted, unable to develop as well. is a condition for the disease to arise and cause more damage than other fields, old leaves close to the base often arise first, severe disease can spread to the upper leaves. The fungus enters the leaves mainly through the stomata, mostly in the young parts of the plant.\nThe growth temperature of the fungus is 5-8°C, 27-35°C.".localized()
                    treatmentTxt = "Rotating maize with legumes.\nUse disease resistant maize.\nCollect the remnants of corn and then take it out of the field to destroy.\nFertilize fully and balance for corn plants. Increase potassium fertilizer for corn.\nTreat corn seeds with hot water of 52°C for 10 minutes.".localized()
                case "Grape___Black_rot":
                    predictedResult = "Black Rot".localized()
                    plantType = "Grape".localized()
                    type = "Fungus".localized()
                    threatLevel = "High".localized()
                case "Grape___Esca_(Black_Measles)":
                    predictedResult = "Grape Esca"
                    plantType = "Grape"
                    type = "Fungus"
                    threatLevel = "High"
                case "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)":
                    predictedResult = "Grape Leaf Blight"
                    plantType = "Grape"
                    type = "Fungus"
                    threatLevel = "High"
                case "Orange___Haunglongbing_(Citrus_greening)":
                    predictedResult = "Orange Haunglongbing"
                    plantType = "Orange"
                    type = "Fungus"
                    threatLevel = "High"
                case "Peach___Bacterial_spot":
                    predictedResult = "Peach Bacterial Spot"
                    plantType = "Peach"
                    type = "Fungus"
                    threatLevel = "High"
                case "Pepper,_bell___Bacterial_spot":
                    predictedResult = "Bacterial Spot"
                    plantType = "Pepper bell"
                    type = "Fungus"
                    threatLevel = "High"
                case "Potato___Early_blight":
                    predictedResult = "Early Blight"
                    plantType = "Potato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Potato___Late_blight":
                    predictedResult = "Potato Late Blight"
                    plantType = "Potato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Squash___Powdery_mildew":
                    predictedResult = "Squash Powdery Mildew"
                    plantType = "Squash"
                    type = "Fungus"
                    threatLevel = "High"
                case "Strawberry___Leaf_scorch":
                    predictedResult = "Strawberry Leaf Scorch"
                    plantType = "Strawberry"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Bacterial_spot":
                    predictedResult = "Tomato Bacterial Spot"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Early_blight":
                    predictedResult = "Tomato Early Blight"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Late_blight":
                    predictedResult = "Tomato Late Blight"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Leaf_Mold":
                    predictedResult = "Tomato Leaf Mold"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Septoria_leaf_spot":
                    predictedResult = "Tomato Septoria Leaf Spot"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Spider_mites Two-spotted_spider_mite":
                    predictedResult = "Tomato Spider Mites"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Target_Spot":
                    predictedResult = "Tomato Target Spot"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Tomato_Yellow_Leaf_Curl_Virus":
                    predictedResult = "Tomato Yellow Leaf Curl Virus"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                case "Tomato___Tomato_mosaic_virus":
                    predictedResult = "Tomato Mosaic Virus"
                    plantType = "Tomato"
                    type = "Fungus"
                    threatLevel = "High"
                default:
                    predictedResult = "No Result"
                }
               
                // Update the main UI thread with our result
                DispatchQueue.main.async { [weak self] in
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = self?.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    controller.image = pickedImage
                    controller.resultText = predictedResult
                    controller.plantTypeText = plantType
                    controller.certaintyText = predconfidence
                    controller.typeText = type
                    controller.threatLevelText = threatLevel
                    controller.aboutText = aboutTxt
                    controller.conditionText = conditionTxt
                    controller.treatmentText = treatmentTxt
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
            

