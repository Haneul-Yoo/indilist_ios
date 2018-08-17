//
//  loginView.swift
//  excs
//
//  Created by user on 2018. 8. 12..
//  Copyright © 2018년 user. All rights reserved.
//

import Alamofire
import UIKit

class loginView: UIViewController {
    let base_url = URL(string: "https://www.indi-list.com/")
    
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
    
    func indi_login(){
        
        
        let userEmail = emailText.text!
        let userPass = passText.text!
        
        let url = "https://www.indi-list.com/auth/login/"
        let headers    = [ "Content-Type" : "application/json"]
        let para : Parameters = [ "id" : userEmail, "pw" : userPass]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
                
            print(response)
            
            let retString = (response.value ?? "")
            
            if(retString == "There is no correct User or There must be login error"){
                print("아이디 혹은 비밀번호가 잘못되었습니다.")
                self.alertAc(mesAlert: "아이디 혹은 비밀번호가 잘못되었습니다.")
            }
            else if(retString == "not verify"){
                print("이메일을 인증해주세요.")
                self.alertAc(mesAlert: "이메일을 인증해주세요.")
            }
            else{
                print("로그인 성공")
                UserDefaults.standard.set(true, forKey: "loginSuccess")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        indi_login()
        
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
