//
//  ViewController.swift
//  excs
//
//  Created by user on 2018. 8. 11..
//  Copyright © 2018년 user. All rights reserved.
//
import Alamofire
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        let loginChecker = UserDefaults.standard.bool(forKey: "loginSuccess")
        if(!loginChecker){
            self.performSegue(withIdentifier: "goMenu", sender: self)
        }
    }
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "loginSuccess")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "goMenu", sender: self)
    }
 
    
}

