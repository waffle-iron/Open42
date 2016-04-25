//
//  ViewController.swift
//  correct42
//
//  Created by larry on 16/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {

	override func viewDidLoad() {
		
	}
	
	@IBAction func connect42(sender: UIButton) {
		let oauthswift = OAuth2Swift(
			consumerKey:    "a94a2723cbc81403ded70bb83444030dd15f47f3c0469bfe9b576cf648739291",
			consumerSecret: "e8011d26fe85872ae11016065a01aa41274740b2ee0f6fb9f962b2c8eb74ba2f",
			authorizeUrl:   "https://api.intra.42.fr/oauth/authorize",
			accessTokenUrl: "https://api.intra.42.fr/oauth/token",
			responseType:   "code"
		)
		oauthswift.authorize_url_handler = SafariURLHandler(viewController: self)
		oauthswift.authorizeWithCallbackURL(
			NSURL(string: "correct42://oauth-callback/intra")!,
			scope: "public", state:"INTRA",
			success: { credential, response, parameters in
				print(credential.oauth_token)
			},
			failure: { error in
				print(error.localizedDescription)
			}
		)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

