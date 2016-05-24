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
	
	func setText(date:String, projectName:String){
		let text = " \(projectName) at\n\(date)"
		allText.text = text
	}

}
