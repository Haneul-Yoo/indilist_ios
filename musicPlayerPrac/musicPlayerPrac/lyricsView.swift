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

    
    @IBOutlet weak var lyricsText: UITextView!
    
    @IBAction func getLyricsBtn(_ sender: Any) {
        let url = "https://indi-list.com/api/GetLyrics/"
        let para : Parameters = [ "mid" : "41768"]
        let headers = ["x-access-token" : "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6InF3ZXIxMjM0IiwiZXhwIjoxNTY4MDM1ODY4LCJleHBfcmVmcmVzaCI6MTUzNjUwMzQ2OCwiaWF0IjoxNTM2NDk5ODY3fQ.BPtr3OS--50lwZaYPiC0VOaBMpqKLEsUQWXusOEtJJEOBVO8Kq-DGL993WyHdPz0tVK75EBPxwBjwOLAXfvosZNCOkssYBBLDnhDKEIZ_RtKh4gJZmUeOqG0tpNQUt_xC16fS7VnOn0uw9saERw8lKDVhEFiWR31ZrIw0UpKjbs"]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
            //json return check in console && json to string
            
            let retString = (response.value ?? "")
            var tempString = retString.components(separatedBy: "\"")
            let tempStringLine = tempString[3].components(separatedBy: "\\n")
            
            self.lyricsText.text = ""
            for line in tempStringLine{
                self.lyricsText.text = (self.lyricsText.text ?? "") + " \n \(line) "
            }
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lyricsText.text = ""

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
