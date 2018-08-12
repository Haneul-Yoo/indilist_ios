//
//  loginView.swift
//  excs
//
//  Created by user on 2018. 8. 12..
//  Copyright © 2018년 user. All rights reserved.
//

import UIKit

class loginView: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let userEmail = emailText.text!
        let userPass = passText.text!
    
        let userEmailStored = UserDefaults.standard.string(forKey: "email")
        let userPassStored = UserDefaults.standard.string(forKey: "pass")
        
        if(userEmail == userEmailStored){
            if(userPass == userPassStored){
                //alertAc(mesAlert: "success")
                
                UserDefaults.standard.set(true, forKey: "loginSuccess")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
               // self.dismiss(animated: true, completion: nil)
            }
            else{
                alertAc(mesAlert: "pass wrong")
            }
        }
        else{
            alertAc(mesAlert: "no such email")
        }
    }
    
    func alertAc(mesAlert:String){
        let myAlert = UIAlertController(title: "Alert", message: mesAlert, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        present(myAlert, animated: true, completion: nil)
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
