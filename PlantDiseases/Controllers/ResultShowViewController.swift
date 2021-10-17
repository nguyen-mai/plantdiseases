//
//  ResultShowViewController.swift
//  PlantDiseases
//
//  Created by Apple on 2021/10/14.
//

import UIKit
import AVKit

class ResultShowViewController: UIViewController {
    
    let navigation: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.openCameraBtnColor
        
        return view
    }()
    
    let backButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Back", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir", size: 22)
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()
    
    let uploadImage: UIImageView = {
       let image = UIImageView(image: UIImage())
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.shadowOpacity = 0.3
        image.layer.shadowColor = UIColor.shadowColor.cgColor
        image.layer.shadowOffset = CGSize(width: 1, height: 5)
        image.layer.cornerRadius = 10
        image.layer.shadowRadius = 8
        image.layer.masksToBounds = true
        image.clipsToBounds = false
        return image
    }()
    
    let dissmissButton: DoneButton = {
        let button = DoneButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(buttonToDissmiss(_:)), for: .touchUpInside)
        
       return button
    }()
    
    let resultLabel: LargeLabel = {
        let label = LargeLabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    let confidenceLabel: LargeLabel = {
        let label = LargeLabel()
        label.backgroundColor = .green
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        
        addSubviews()
        setupLayout()
    }
    
    func addSubviews() {
        view.addSubview(navigation)
        view.addSubview(backButton)
//        view.addSubview(dissmissButton)
//        view.addSubview(uploadImage)
//        view.addSubview(resultLabel)
    }
    
    func setupLayout() {
        
        navigation.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navigation.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        navigation.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigation.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        backButton.centerYAnchor.constraint(equalTo: navigation.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
    }
    
    @objc func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }

    
    @objc func buttonToDissmiss(_ sender: BtnPleinLarge) {
        self.dismiss(animated: true, completion: nil)
    }
}
