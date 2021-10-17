//
//  LargeLabel.swift
//  PlantDiseases
//
//  Created by Apple on 2021/10/16.
//

import UIKit

class LargeLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        font = UIFont(name: "Avenir", size: 22)
        textColor = UIColor.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
