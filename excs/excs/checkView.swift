//
//  checkView.swift
//  excs
//
//  Created by user on 2018. 8. 11..
//  Copyright © 2018년 user. All rights reserved.
//

import Alamofire
import UIKit

class checkView: UIViewController {

    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var pwText: UITextField!
    @IBOutlet weak var pwChkText: UITextField!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!

    @IBOutlet weak var pwWarnLabel: UILabel!
    
    @IBOutlet weak var dupliIdBtn: UIButton!
    @IBOutlet weak var dupliNameBtn: UIButton!
    @IBOutlet weak var dupliEmailBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    
    var idChk = false
    var nameChk = false
    var emailChk = false
    var pwChk = false
    
    let headers    = [ "Content-Type" : "application/json"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue("", forKey: "non_dupId")
        UserDefaults.standard.setValue("", forKey: "non_dupName")
        UserDefaults.standard.setValue("", forKey: "non_dupEmail")
        UserDefaults.standard.setValue("", forKeyPath: "emailError")
        UserDefaults.standard.synchronize()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changePwText(_ sender: Any) {
        let pwStr = pwText.text!
        let pwChkStr = pwChkText.text!
        pwChk = false
        if(!patternChk(str: pwStr)) {
            pwWarnLabel.text = "비밀번호는 영문, 숫자만 가능합니다."
        }
        else if(strlen(pwStr) < 6) {
            pwWarnLabel.text = "비밀번호는 6자 이상이어야 합니다."
        }
        else if(pwChkStr == ""){
            pwWarnLabel.text = "비밀번호를 한번 더 입력해주세요."
        }
        else if(pwStr != pwChkStr) {
            pwWarnLabel.text = "비밀번호가 일치하지 않습니다."
        }
        else{
            pwChk = true
            pwWarnLabel.text = ""
        }
    }
    
    @IBAction func changePwChkText(_ sender: Any) {
        let pwStr = pwText.text!
        let pwChkStr = pwChkText.text!
        if(pwStr != pwChkStr) {
            pwWarnLabel.text = "비밀번호가 일치하지 않습니다."
            pwChk = false
        }
        else{
            pwWarnLabel.text = ""
            pwChk = true
        }
    }
    
    
    //duplicated checking
    @IBAction func changeIdText(_ sender: Any) {
        if(idChk == true){
            self.dupliIdBtn.isEnabled = true
            self.idChk = false
            UserDefaults.standard.setValue("", forKeyPath: "non_dupId")
            UserDefaults.standard.synchronize()
        }
    }
    @IBAction func dupliIdBtn(_ sender: Any) {
        let idStr = idText.text!
        
        //base check
        if(strlen(idStr)<6){
            self.loginAlert(alertMessage: "아이디는 6자 이상이어야 합니다.")
            return
        }
        else if(!patternChk(str: idStr)){
            self.loginAlert(alertMessage: "영문 또는 숫자만 가능합니다.")
            return
        }
        
        let keyStr = "non_dupId"
        dupliChk(str: idStr, post: "checkId/", paraIndex: "id", key_value: keyStr, completion: {
            if(UserDefaults.standard.string(forKey: keyStr) == ""){
                self.loginAlert(alertMessage: "중복된 아이디가 있습니다.")
                print("중복")
            }
            else{
                self.loginAlert(alertMessage: "사용가능한 아이디입니다.")
                print("중복아님")
                self.dupliIdBtn.isEnabled = false
                self.idChk = true
            }
        })
    }
    
    
    @IBAction func changeNameText(_ sender: Any) {
        if(nameChk == true){
            self.dupliNameBtn.isEnabled = true
            self.nameChk = false
            UserDefaults.standard.setValue("", forKeyPath: "non_dupNick")
            UserDefaults.standard.synchronize()
        }
    }

    @IBAction func dupliNameBtn(_ sender: Any) {
        let nameStr = nameText.text!
        //duplicate check
        let keyStr = "non_dupNick"
        dupliChk(str: nameStr, post: "checkNick/", paraIndex: "nick", key_value: keyStr, completion: {
            if(UserDefaults.standard.string(forKey: keyStr) == ""){
                self.loginAlert(alertMessage: "중복된 닉네임이 있습니다.")
            }
            else{
                self.loginAlert(alertMessage: "사용가능한 닉네임입니다.")
                self.dupliNameBtn.isEnabled = false
                self.nameChk = true
            }
        })
    }
    
    @IBAction func changeEmailText(_ sender: Any) {
        if(emailChk == true){
            self.dupliEmailBtn.isEnabled = true
            self.emailChk = false
            UserDefaults.standard.setValue("", forKeyPath: "non_dupEmail")
            UserDefaults.standard.setValue("", forKeyPath: "emailError")
            UserDefaults.standard.synchronize()
        }
    }
    @IBAction func dupliEmailBtn(_ sender: Any) {
        let emailStr = emailText.text!
        
        //duplicate check
        let keyStr = "non_dupEmail"
        dupliChk(str: emailStr, post: "checkEmail/", paraIndex: "email", key_value: keyStr, completion: {
            let emailErrorCode = UserDefaults.standard.string(forKey: "emailError")
            if(emailErrorCode != ""){
                switch emailErrorCode{
                case "not validated":
                    self.loginAlert(alertMessage: "올바른 형식이 아닙니다.")
                case "error":
                    self.loginAlert(alertMessage: "오류")
                default:
                    self.loginAlert(alertMessage: "오류")
                }
                UserDefaults.standard.setValue("", forKey: "emailError")
                UserDefaults.standard.synchronize()
            }
            else if(UserDefaults.standard.string(forKey: keyStr) == ""){
                self.loginAlert(alertMessage: "이미 있는 이메일입니다.")
            }
            else{
                self.loginAlert(alertMessage: "사용가능한 이메일입니다.")
                self.dupliEmailBtn.isEnabled = false
                self.emailChk = true
            }
        })
    }
    
    func dupliChk(str: String, post: String, paraIndex: String, key_value: String, completion: @escaping ()->()){
        
        let url = "https://www.indi-list.com/" + post
        let para : Parameters = [ paraIndex : str]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
            //json return check in console && json to string
            print(response)
            let retString = (response.value ?? "")
            
            if(retString == "true"){
                UserDefaults.standard.setValue(str, forKey: key_value)
                print("없음")
            }
            else if(retString == "false"){
                UserDefaults.standard.setValue("", forKey: key_value)
                print("이미 있음")
            }
            else if(retString == "not validated"){
                UserDefaults.standard.setValue("not validated", forKeyPath: "emailError")
                print("올바른형식이아님")
            }
            else if(retString == "error"){
                UserDefaults.standard.setValue("error", forKeyPath: "emailError")
                print("오류")
            }
            else{
                print("error why?")
            }
            UserDefaults.standard.synchronize()
            completion()
        }
        return
    }
    
    func patternChk(str: String) -> Bool {
        let patReg = "^[a-zA-Z0-9]+$"
        let patTest = NSPredicate(format:"SELF MATCHES %@", patReg)
        return patTest.evaluate(with: str)
    }
    
    
    //final check
    @IBAction func registerBtn(_ sender: Any) {
        let url = "https://www.indi-list.com/auth/signup/"
        
        let para : Parameters = ["id": idText.text!, "pw": pwText.text!, "email": emailText.text!, "name": nameText.text!]
        //check all things to fill
        if(idChk && nameChk && emailChk && pwChk){
            print("all checked")
            
            loginAlert(alertMessage: "이메일 인증 완료 후 회원가입이 완료됩니다.")
            
            Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers : headers).responseString { response in
                
                print(response)
                let retString = (response.value ?? "")
                print(retString)
            }
        }
        else {
            print("모든 확인을 마쳐주세요")
        }
        return
    }
    
    
    
    
    //alert
    func loginAlert(alertMessage : String){
        let myAlert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        present(myAlert, animated: true, completion: nil)
    }
    
    func fill_init(){
        id_init()
        pw_init()
    }
    func id_init(){
        idText.text! = ""
    }
    func pw_init(){
        pwText.text! = ""
        pwChkText.text! = ""
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
