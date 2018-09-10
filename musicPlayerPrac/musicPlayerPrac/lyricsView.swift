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

    var lyricsBool = Bool()
    var firstLoadString = String()
    @IBOutlet weak var lyricsText: UITextView!
    
    @IBAction func getLyricsBtn(_ sender: Any) {
        if(!lyricsBool){
            if(firstLoadString == ""){
                let url = "https://indi-list.com/api/GetLyrics/"
                let para : Parameters = [ "mid" : "41768"]
                let headers = ["x-access-token" : "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6InF3ZXIxMjM0IiwiZXhwIjoxNTY4MDg2OTM0LCJleHBfcmVmcmVzaCI6MTUzNjU1NDUzNCwiaWF0IjoxNTM2NTUwOTM0fQ.IavV9USJb3W_ymlD73TDViNfqn2R5uN0IAaPHQslDMZ8NjS4ZPnbbIWzdsLNjePwk3HFiOuPlofb9tF0KF6tAd8u2bBZqKho-9DLMo782XbrZltWEQ2p7smpZZaK0hWbv7y8lJGrMu47WHup1sVII3jN8TyoEIq93adicL-adzg"]
                
                Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
                    //json return check in console && json to string
                    
                    let retString = (response.value ?? "")
                    var tempString = retString.components(separatedBy: "\"")
                    let tempStringLine = tempString[3].components(separatedBy: "\\n")
                    
                    self.lyricsText.text = ""
                    for line in tempStringLine{
                        self.lyricsText.text = (self.lyricsText.text ?? "") + "\n\(line) "
                    }
                }
            }
            else{
                self.lyricsText.text = firstLoadString
            }
            
            lyricsBool = true
        }
        else{
            firstLoadString = lyricsText.text!
            self.lyricsText.text = ""
            lyricsBool = false
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lyricsText.text = ""

        lyricsBool = false
        firstLoadString = ""
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
