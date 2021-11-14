//
//  ListViewCell.swift
//  PlantDiseases
//
//  Created by Apple on 2021/11/7.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var diseaseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
