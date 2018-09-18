//
//  noticeView.swift
//  musicPlayerPrac
//
//  Created by user on 2018. 9. 15..
//  Copyright © 2018년 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class noticeView: UIViewController {

    @IBOutlet weak var noticeText: UITextView!
    override func viewDidLoad() {
        noticeLoad(completion:{
            super.viewDidLoad()
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func noticeLoad(completion: @escaping ()->()){
        let url = "https://www.indi-list.com/GetNoticeList"
        let headers = [ "Content-Type" : "application/json" ]
        let para : Parameters = [ "num" : Int(1)]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
            
            print(response)
            let retString = (response.value ?? "")
            var retStringArray = retString.components(separatedBy: "\"")
            retStringArray = retStringArray[16].components(separatedBy: "}")
            retStringArray = retStringArray[0].components(separatedBy: ":")
            print(retStringArray[1])
            
            completion()
        }
    }
    
    @IBAction func noticeTextLoad(_ sender: Any) {
        let url = "https://www.indi-list.com/GetNotice"
        let headers = [ "Content-Type" : "application/json" ]
        let para : Parameters = [ "noticenum" : 1]
        
        noticeText.text = ""
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
            
            
            let retString = (response.value ?? "")
            let retStringLine = retString.components(separatedBy: "\\r\\n")
            
            for line in retStringLine{
                let tempLine = line.components(separatedBy: "\\").joined()
                self.noticeText.text = (self.noticeText.text ?? "") + "\n\(tempLine)"
                print(tempLine)
            }
            
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
