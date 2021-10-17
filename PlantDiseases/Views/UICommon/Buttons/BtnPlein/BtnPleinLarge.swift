//
//  BtnPleinLarge.swift
//  exmachina
//
//  Created by M'haimdat omar on 30-05-2019.
//  Copyright © 2019 M'haimdat omar. All rights reserved.
//

import UIKit

struct IconTextButtonViewModel {
    let text: String
    let image: UIImage?
    let backgroundColor: UIColor?
    let borderColor: CGColor?
}

final class BtnPleinLarge: BtnPlein {
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(with viewModel: IconTextButtonViewModel) {
        super.init(frame: .zero)
        
        setTitle(viewModel.text, for: .normal)
        addRightImage(image: viewModel.image!.resized(newSize: CGSize(width: 50, height: 50)), offset: 30)
        backgroundColor = viewModel.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 5)
        layer.cornerRadius = 10
        layer.shadowRadius = 8
        layer.borderColor = viewModel.borderColor
        layer.masksToBounds = true
        clipsToBounds = false
        contentHorizontalAlignment = .left
        layoutIfNeeded()
        contentHorizontalAlignment = .left
        layoutIfNeeded()
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        titleEdgeInsets.left = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

}
