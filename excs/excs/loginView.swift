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
        UserDefaults.standard.setValue(false, forKey: "policySuccess")
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
        let headers    = [ "Content-Type" : "application/json" ]
        let para : Parameters = [ "id" : userEmail, "pw" : userPass]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
            
            print(response)
            if(response.result.isSuccess){
                let retString = (response.value ?? "")
                print(retString)
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
                    
                    let retStringArray = retString.components(separatedBy: "\"")
                    
                    self.loginUserInfo(userInfo: retStringArray)
                    
                }
            }
            else if(response.result.isFailure){
                self.alertAc(mesAlert: "서버에 연결되어있지 않습니다.")
                print("서버 연결 안됨")
            }
            
            print(response.result)
        }

    }
    
    //(login success) save login information in app
    func loginUserInfo(userInfo: Array<String>){
        print(userInfo)
        var tempEV : Array<String> = userInfo[22].components(separatedBy: ":")
        tempEV = tempEV[1].components(separatedBy: ",")
        var tempUQ : Array<String> = userInfo[28].components(separatedBy: ":")
        tempUQ = tempUQ[1].components(separatedBy: ",")
        UserDefaults.standard.set(String(userInfo[3]), forKey: "loginName")
        print(userInfo[3])
        UserDefaults.standard.set(String(userInfo[7]), forKey: "loginId")
        print(userInfo[7])
        UserDefaults.standard.set(String(userInfo[11]), forKey: "loginSignuptime")
        print(userInfo[11])
        UserDefaults.standard.set(String(userInfo[15]), forKey: "loginPhoto")
        print(userInfo[15])
        UserDefaults.standard.set(String(userInfo[19]), forKey: "loginEmail")
        print(userInfo[19])
        UserDefaults.standard.set(String(tempEV[0]), forKey: "loginEmailverify")
        print(tempEV[0])
        UserDefaults.standard.set(String(userInfo[25]), forKey: "loginIsAritist")
        print(userInfo[25])
        UserDefaults.standard.set(String(tempUQ[0]), forKey: "loginUser_quit")
        print(tempUQ[0])
        UserDefaults.standard.set(String(userInfo[31]), forKey: "loginToken")
        print(userInfo[31])
        UserDefaults.standard.synchronize()
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
