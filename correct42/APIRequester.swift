//
//  APIManager.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Alamofire
import OAuthSwift
import SwiftyJSON

class APIRequester {
	
	static let	baseURLString = "https://api.intra.42.fr/v2"
	static var	OAuthToken: String?
	
	static func Shared() -> APIRequester {
		return (APIRequester())
	}
	
	func request(mutableUrlRequest:NSMutableURLRequest, success: (JSON)->Void, failure:(NSError)->Void){
		Alamofire.request(mutableUrlRequest)
			.response { request, response, data, error in
				guard error == nil else { failure(error!); return }
				guard data == nil else {success(JSON(data!)); return }
		}
	}
	
	func connectApi(viewController:UIViewController, success:(Void)->Void, failure:(NSError)->Void){
		let oauthswift = OAuth2Swift(
			consumerKey:    "a94a2723cbc81403ded70bb83444030dd15f47f3c0469bfe9b576cf648739291",
			consumerSecret: "e8011d26fe85872ae11016065a01aa41274740b2ee0f6fb9f962b2c8eb74ba2f",
			authorizeUrl:   "https://api.intra.42.fr/oauth/authorize",
			accessTokenUrl: "https://api.intra.42.fr/oauth/token",
			responseType:   "code"
		)
		oauthswift.authorize_url_handler = SafariURLHandler(viewController: viewController)
		oauthswift.authorizeWithCallbackURL(
			NSURL(string: "correct42://oauth-callback/intra")!,
			scope: "public", state:"INTRA",
			success: { credential, response, parameters in
				APIRequester.OAuthToken = credential.oauth_token
				success()
			},
			failure: { error in
				failure(error)
			}
		)
	}

}

