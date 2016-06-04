//
//  UILabelPhone.swift
//  Open42
//
//  Created by larry on 04/06/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class UILabelPhone: UILabel {

	var delegatePhoneNumber:UIGestureRecognizerDelegate? {
		didSet{
			if let delPN = oldValue{
				updateTap(delPN)
			}
		}
	}
	
	private func updateTap(delegatePhoneNumber:UIGestureRecognizerDelegate){
		let tap = UITapGestureRecognizer(target: delegatePhoneNumber, action: #selector(UILabelPhone.clicPhoneNumber))
		addGestureRecognizer(tap)
	}
	
	func clicPhoneNumber(){
		if var phoneNumber = self.text {
			phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("(", withString: "")
			phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString(")", withString: "")
			phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("-", withString: "")
			phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString(".", withString: "")
			phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString(" ", withString: "")
			if let phoneNumberURL = NSURL(string: "tel://\(phoneNumber)"){
				UIApplication.sharedApplication().openURL(phoneNumberURL)
			}
		}
	}
}
