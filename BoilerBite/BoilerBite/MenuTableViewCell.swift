//
//  MenuTableViewCell.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/27/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.accessoryType = selected ? .checkmark : .none
    }

}
