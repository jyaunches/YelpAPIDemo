//
//  ViewController.swift
//  YelpDemo
//
//  Created by julie.yaunches on 3/21/16.
//  Copyright © 2016 julie.yaunches. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import OAuthSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {

        let credential = OAuthSwiftCredential(consumer_key: "HNzX6lrYHzcHemGqKkGASw", consumer_secret: "tyT2t6rVi7sCpnv7H5RZcMijIGI")
        credential.oauth_token_secret = "UWKa1SP9x5M0YnUftrc5tbnidE4"
        credential.oauth_token = "a_476XWOTkqXWEYN2-lze5P8ODFxpHU8"

        let url = NSURL(string: "https://api.yelp.com/v2/search")
        
        let params: [String:AnyObject] = ["term": "german+food",
                                          "location": "Hayes",
                                          "cll": "37.77493,-122.419415"]

        let authParams: [String:AnyObject] = ["oauth_consumer_key": "HNzX6lrYHzcHemGqKkGASw",
                                          "oauth_token": "a_476XWOTkqXWEYN2-lze5P8ODFxpHU8",
                                          "oauth_signature_method": "hmac-sha1",
                                          "oauth_signature": credential.signatureForMethod(OAuthSwiftHTTPRequest.Method.GET, url: url!, parameters: params),
                                          "oauth_timestamp": String(Int64(NSDate().timeIntervalSince1970)),
                                          "oauth_nonce": OAuthSwiftCredential.generateNonce(),
                                              "oauth_version": "1.0"]

        let newParams = params + authParams

        
        Alamofire.request(.GET, "https://api.yelp.com/v2/search", parameters: newParams, encoding: .JSON)
            .responseJSON {
                response in
                if let data = response.data {
                    let couponJSON = JSON(data: data)
                    print(couponJSON)
                }
        }
    }
}

