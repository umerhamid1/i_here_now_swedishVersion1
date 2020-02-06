//
//  MeditationDetailsTableViewCell.swift
//  i_here_now
//
//  Created by umer hamid on 1/29/20.
//  Copyright © 2020 Livheim AB. All rights reserved.
//

import UIKit

class MeditationDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var meditationTitle: UILabel!
    
    @IBOutlet weak var meditationDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        meditationTitle.textColor = .white
        meditationDuration.textColor = .white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
