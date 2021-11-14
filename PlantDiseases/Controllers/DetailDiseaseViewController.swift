//
//  DetailDiseaseViewController.swift
//  PlantDiseases
//
//  Created by Apple on 2021/11/7.
//

import UIKit

class DetailDiseaseViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var backText: UIButton!
    
    var img = UIImage()
    var lbl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        label.text = lbl
        image.image = img
        
        backText.setTitle("Back".localized(), for: .normal)
    }
    
    @IBAction func backTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
