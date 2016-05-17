//
//  ScaleTeamTableViewCell.swift
//  correct42
//
//  Created by larry on 15/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class ScaleTeamTableViewCell: UITableViewCell {


	@IBOutlet weak var allText: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setText(owner:Bool, correctedLogin:String?, date:String, projectName:String){
		var correctedLoginCheck = correctedLogin
		if (correctedLogin != nil){
			correctedLoginCheck = "someone"
		}
		var text = "You'll correct \(correctedLoginCheck!) at\n\(date)\non \(projectName)"
		if owner{
			text = "You'll be corrected by \(correctedLoginCheck!) at\n\(date)\non \(projectName)"
		} else {
			
		}
		allText.text = text
	}

}
