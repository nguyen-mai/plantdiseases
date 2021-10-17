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
        btn.addTarget(self, action: #selector(buttonToDissmiss(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    let uploadImage: UIImageView = {
       let image = UIImageView(image: UIImage())
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
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
    
    let result: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 22)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    let accuracyLabel: LargeLabel = {
        let label = LargeLabel()
        label.text = "Certainty:"
        
        return label
    }()
    
    let typeLabel: LargeLabel = {
        let label = LargeLabel()
        label.text = "Type:"
        
        return label
    }()
    
    let levelLabel: LargeLabel = {
        let label = LargeLabel()
        label.text = "Threat level:"
        
        return label
    }()
    
    let type: LargeLabel = {
        let label = LargeLabel()
        
        return label
    }()
    
    let accuracy: LargeLabel = {
        let label = LargeLabel()
        
        return label
    }()
    
    let level: LargeLabel = {
        let label = LargeLabel()
        
        return label
    }()
    
    let largeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        // StackView settings
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5
        
        return stack
    }()
    
    let smallFirstStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    let smallSecondStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        addSubviews()
        setupLayout()
    }
    
    func addSubviews() {
        view.addSubview(navigation)
        view.addSubview(backButton)
        view.addSubview(result)
        view.addSubview(resultLabel)
        view.addSubview(largeStackView)
        view.addSubview(smallFirstStackView)
        view.addSubview(smallSecondStackView)
        
        // Add StackView
        largeStackView.addArrangedSubview(uploadImage)
        largeStackView.addArrangedSubview(smallFirstStackView)
        largeStackView.addArrangedSubview(smallSecondStackView)
        
        smallFirstStackView.addArrangedSubview(typeLabel)
        smallFirstStackView.addArrangedSubview(accuracyLabel)
        smallFirstStackView.addArrangedSubview(levelLabel)
        
        smallSecondStackView.addArrangedSubview(accuracy)
        smallSecondStackView.addArrangedSubview(type)
        smallSecondStackView.addArrangedSubview(level)
    }
    
    func setupLayout() {
        
        navigation.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navigation.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.18).isActive = true
        navigation.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigation.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        backButton.bottomAnchor.constraint(equalTo: navigation.bottomAnchor, constant: -5).isActive = true
        
        result.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        result.topAnchor.constraint(equalTo: navigation.bottomAnchor, constant: 20).isActive = true
        result.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        result.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        
        // Autolayout stack view
        largeStackView.topAnchor.constraint(equalTo: navigation.bottomAnchor, constant: 10).isActive = true
        largeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        largeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        uploadImage.widthAnchor.constraint(equalTo: uploadImage.heightAnchor, multiplier: 1).isActive = true
        smallFirstStackView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    @objc func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }

    
    @objc func buttonToDissmiss(_ sender: BtnPleinLarge) {
        self.dismiss(animated: true, completion: nil)
    }
}
