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
    // side menu
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sideMenuOpen = false
        sideMenuConstraint.constant = -272
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
        

        // chart
        chartLoad(completion: {
            print("fin")
        })
    }
    
    @objc func toggleSideMenu() {
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -272
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    
    // chart
    @IBOutlet weak var albumArtView: UIImageView!
    
    var data = Data()

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
