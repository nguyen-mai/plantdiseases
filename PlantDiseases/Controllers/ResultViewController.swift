//
//  DetailViewController.swift
//  PlantDiseases
//
//  Created by Apple on 2021/11/7.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var plant: UILabel!
    @IBOutlet weak var img: UIImageView! 
    @IBOutlet weak var certainty: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var threatLevel: UILabel!
    
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var conditionBtn: UIButton!
    @IBOutlet weak var treatmentBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var treatment: UILabel!
    
    var image = UIImage()
    var plantTypeText = ""
    var resultText = ""
    var certaintyText = ""
    var typeText = ""
    var threatLevelText = ""
    var aboutText = ""
    var conditionText = ""
    var treatmentText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        
        // Tittle Button
        aboutBtn.setTitle("Symptom".localized().uppercased(), for: .normal)
        conditionBtn.setTitle("Conditions for disease development".localized().uppercased(), for: .normal)
        treatmentBtn.setTitle("Prevention and treatment".localized().uppercased(), for: .normal)
        backBtn.setTitle("Back".localized(), for: .normal)
        
        
        img.image = image
        result.text = resultText
        plant.text = plantTypeText
        certainty.text = "Certainty".localized() + ": \(certaintyText) %"
        type.text = "Type".localized() + ": \(typeText)"
        threatLevel.text = "Threat Level".localized() + ": \(threatLevelText)"
        about.text = aboutText
        condition.text = conditionText
        treatment.text = treatmentText
    }

    @IBAction func aboutTap(_ sender: Any) {
    }
    
    @IBAction func conditionTap(_ sender: Any) {
    }
    
    
    @IBAction func treatementTap(_ sender: Any) {
    }
    
    @IBAction func backTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
