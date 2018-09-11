//
//  chartView.swift
//  excs
//
//  Created by user on 2018. 9. 11..
//  Copyright © 2018년 user. All rights reserved.
//

import UIKit
import Alamofire

class chartView: UIViewController {
    @IBOutlet weak var albumArtView: UIImageView!
    
    var data = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        chartLoad(completion: {
            print("fin")
        })
        
        let imageUrl = URL(string: "http://d1e9zqysfkgjz.cloudfront.net/AlbumArt/pc0211/62451")
        let imageData:NSData = NSData(contentsOf: imageUrl!)!
        albumArtView.image = UIImage(data: imageData as Data)
        // Do any additional setup after loading the view.
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func chartLoad(completion : @escaping ()->()){
        let url = URL(string: "https://indi-list.com/getlist")
        let headers = [ "Content-Type" : "application/json" ]
        let para : Parameters = [ "" : ""]
        Alamofire.request(url!, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
            //json return check in console && json to string
            
            let retString = (response.value ?? "")
            print(retString)
            
        }
        
        completion()
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
