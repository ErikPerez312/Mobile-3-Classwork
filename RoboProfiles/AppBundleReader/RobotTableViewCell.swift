//
//  RobotTableViewCell.swift
//  AppBundleReader
//
//  Created by Erik Perez on 10/27/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

class RobotTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personalityLabel: UILabel!
    @IBOutlet weak var phraseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
