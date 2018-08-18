//
//  policyView.swift
//  excs
//
//  Created by user on 2018. 8. 18..
//  Copyright © 2018년 user. All rights reserved.
//
import UIKit

class policyView: UIViewController {
    
    @IBOutlet weak var agreeLabel: UILabel!
    
    @IBOutlet weak var policyWebView: UIWebView!
    
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    override func viewDidLoad() {
        loadPolicy(completion: {
            super.viewDidLoad()
            UserDefaults.standard.setValue(false, forKey: "policySuccess")
            UserDefaults.standard.synchronize()
        })
        nextBtn.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    func loadPolicy(completion: @escaping ()->()){
        let policyUrl = URL(string: "https://www.indi-list.com/policy/privacy")
        let request = NSURLRequest(url: policyUrl!)
        policyWebView.loadRequest(request as URLRequest)
        completion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func agreeBtn(_ sender: Any) {
        let policyKey = "policySuccess"
        let checker = UserDefaults.standard.bool(forKey: policyKey)
        if(!checker){
            nextBtn.isEnabled = true
            UserDefaults.standard.setValue(true, forKey: policyKey)
        }
        else{
            nextBtn.isEnabled = false
            UserDefaults.standard.setValue(false, forKey: policyKey)
        }
        UserDefaults.standard.synchronize()
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
