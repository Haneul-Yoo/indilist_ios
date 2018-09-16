//
//  personalCheckView.swift
//  musicPlayerPrac
//
//  Created by user on 2018. 9. 16..
//  Copyright © 2018년 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class personalCheckView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        checker(domain: "/api/PersonalSongList", completion: {
            print("personal song list loaded")
        })
        checker(domain: "/api/PersonalLikeList", completion: {
            print("personal like list loaded")
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checker(domain: String, completion: @escaping ()->()){
        let url = "https://indi-list.com" + domain
        let para : Parameters = [ "id" : "qwer1234"]
        let headers = ["x-access-token" : "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6InF3ZXIxMjM0IiwiZXhwIjoxNTY4NjA3MDk5LCJleHBfcmVmcmVzaCI6MTUzNzA3NDY5OSwiaWF0IjoxNTM3MDcxMDk4fQ.Rm61uLfILtd2ukeMNWeYfwE6aoVfW4qKywdmoXKYqTdYrlF1WDsKqVZsi1hmhXdw7RulEKW374awdgyJVavSe4SJCRTdmKiDWWE-R32To1qJuNk24q8W62b3PHHsAOZ0k6h8qk_60bRk5WBCpTc1boHHXmnaHPrD0DRj73Rd7ek"]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
            print(response)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
