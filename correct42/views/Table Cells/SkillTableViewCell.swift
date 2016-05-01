//
//  SkillTableViewCell.swift
//  correct42
//
//  Created by larry on 01/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

	@IBOutlet weak var skillNameLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
