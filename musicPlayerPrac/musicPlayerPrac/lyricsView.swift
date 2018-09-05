//
//  lyricsView.swift
//  musicPlayerPrac
//
//  Created by user on 2018. 9. 4..
//  Copyright © 2018년 user. All rights reserved.
//

import Alamofire
import UIKit

class lyricsView: UIViewController {

    
    //set label... line : 0, line break : word
    @IBOutlet weak var lyricsLabel: UILabel!
    
    @IBAction func getLyricsBtn(_ sender: Any) {
        let url = "https://indi-list.com/api/GetLyrics/"
        let para : Parameters = [ "mid" : "41768"]
        let headers = ["x-access-token" : "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6InF3ZXIxMjM0IiwiZXhwIjoxNTY3NjQyMzk1LCJleHBfcmVmcmVzaCI6MTUzNjEwOTk5NSwiaWF0IjoxNTM2MTA2Mzk0fQ.N6QcZplSLW2flSBwDV2EIzG2aSZteX7s_xFYYubc8_AP4Xq6VpTJtWw4wKMxrf6TrAtu2TKTwpl21o1Q3Fqb_FgbPVYrYPJwGDa3tUAbcxi_YUxEhSr1q9ltIwkeNbyDn0a0glf-hHeNe02RXl37HXEmo9K5_FTnPC7y_FpoRpE"]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
            //json return check in console && json to string
            
            let retString = (response.value ?? "")
            var tempString = retString.components(separatedBy: "\"")
            //self.lyricsLabel.text = tempString[3]
            print(tempString[3])
            self.lyricsLabel.text = tempString[3]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
