//
//  ViewController.swift
//  pnutAPI
//
//  Created by Wataru Nishimoto on 2018/6/2.
//  Copyright © 2018 Wataru Nishimoto. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {
    var oauthswift: OAuth2Swift?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchUpInside(_ sender: Any) {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist" ),
            let plist = NSDictionary(contentsOfFile: filePath) else {
                fatalError("Could not load plist")
        }
        guard let clientId = plist["PnutClientID"] as? String,
            let clientSecret = plist["PnutClientSecret"] as? String else {
                fatalError("Could not read secrets")
        }

        oauthswift = OAuth2Swift(
            consumerKey: clientId,
            consumerSecret: clientSecret,
            authorizeUrl: "https://pnut.io/oauth/authenticate",
            responseType: "token"
        )
        guard let oauthswift = oauthswift else {
            fatalError()
        }

        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        oauthswift.authorize(
            withCallbackURL: URL(string: "pnut-callback://pnut-callback/pnut")!,
            scope: "basic+stream+write_post+follow+update_profile+presence+messages+files+polls", state: "",
            success: { credential, response, parameters in
                let ud = UserDefaults.standard
                ud.set(credential.oauthToken, forKey: "OAuthToken")
                ud.synchronize()
                print(credential.oauthToken)
        },
            failure: { error in
                print(error.localizedDescription)
        }
        )
    }
}
