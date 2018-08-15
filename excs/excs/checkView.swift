//
//  checkView.swift
//  excs
//
//  Created by user on 2018. 8. 11..
//  Copyright © 2018년 user. All rights reserved.
//

import UIKit

class checkView: UIViewController {

    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var thirdText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkBtn(_ sender: Any) {
        let aText = firstText.text!
        let bText = secondText.text!
        let cText = thirdText.text!
        
        if(aText.isEmpty || bText.isEmpty || cText.isEmpty){
            loginAlert(alertMessage: "please fill the all blank")
            fill_init()
            return
        }
        else if(bText != cText){
            loginAlert(alertMessage: "two pass are different")
            fill_init()
            return
        }
        
        UserDefaults.standard.set(aText, forKey: "email")
        UserDefaults.standard.set(bText, forKey: "pass")
        UserDefaults.standard.synchronize()
 
        
        let myAlert = UIAlertController(title: "Success", message: "Thank you", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            action in self.dismiss(animated: true, completion: nil)
        }
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
        
        
        return
    }
    
    func loginAlert(alertMessage : String){
        let myAlert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        present(myAlert, animated: true, completion: nil)
    }
    
    func fill_init(){
        firstText.text! = ""
        secondText.text! = ""
        thirdText.text! = ""
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
