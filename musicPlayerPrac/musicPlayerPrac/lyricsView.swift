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
                let headers = ["x-access-token" : "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6InF3ZXIxMjM0IiwiZXhwIjoxNTY4MTk3NTE4LCJleHBfcmVmcmVzaCI6MTUzNjY2NTExOCwiaWF0IjoxNTM2NjYxNTE3fQ.DM7qDud47ZzpmlHlrkmwba0f4OjNgUIvI2WX3TpmCZ2QssRNBVItZ9GO0gEkUSbNDBmaIft-xnE0un4VuxV_cmp0dFlebr7E7MJfn2KxnyXJMh6f5mE0a3f7Osp0qo8g0_4po2wI8YbQY3JpHEEoM6lH5WYPSDk4rPlag7ewBP0"]
                
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
