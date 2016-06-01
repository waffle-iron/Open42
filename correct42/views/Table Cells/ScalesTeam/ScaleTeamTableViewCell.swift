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
	
	func setText(owner:Bool, correctedLogin:String?, date:NSDate, projectName:String){
		var correctedLoginCheck = correctedLogin
		if (correctedLogin == nil){
			correctedLoginCheck = "someone"
		}
		let dateFormat = NSDateFormatter()
		dateFormat.locale = NSLocale(localeIdentifier: "fr_FR")
		dateFormat.dateFormat = "'on' dd/LL/yyyy 'at' HH:mm"
		var text = "You'll correct \(correctedLoginCheck!) \n\(dateFormat.stringFromDate(date))\nfor \(projectName)"
		if owner{
			text = "You'll be corrected by \(correctedLoginCheck!)\n\(dateFormat.stringFromDate(date))\n for \(projectName)"
		}
		allText.text = text
	}
	
	func setText(date:String, projectName:String){
		let text = " \(projectName) at\n\(date)"
		allText.text = text
	}
}
