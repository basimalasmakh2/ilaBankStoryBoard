//
//  MyTableViewCell.swift
//  IlaBankStoryboard
//
//  Created by Yousif Radhi on 12/28/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet var countryLabel: UILabel!
    
    @IBOutlet var carNameLabel: UILabel!
    
    @IBOutlet weak var carImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
