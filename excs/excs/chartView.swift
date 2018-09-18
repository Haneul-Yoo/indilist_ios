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
// <<<<<<< Haneul-Yoo-patch-1
//     // side menu
//     @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
//     var sideMenuOpen = false
// =======
//     @IBOutlet weak var albumArtView: UIImageView!
//     @IBOutlet weak var artistImgView: UIImageView!
// >>>>>>> master
    
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
// <<<<<<< Haneul-Yoo-patch-1
// =======
        
//         if let url = URL(string: "https://d1e9zqysfkgjz.cloudfront.net/AlbumArt/ajoumidi/57305") {
//             albumArtView.contentMode = .scaleAspectFit
//             downloadImage(imgView: albumArtView, from: url)
//         }
//         if let url = URL(string: "https://d1e9zqysfkgjz.cloudfront.net/profile/ajoumidi/ajoumidi_profile_1528543868648") {
//             artistImgView.contentMode = .scaleAspectFit
//             downloadImage(imgView: artistImgView, from: url)
//         }
        
//     }
    
//     func downloadImage(imgView: UIImageView, from url: URL) {
//         print("Download Started")
//         getData(from: url) { data, response, error in
//             guard let data = data, error == nil else {
//                 print("error")
//                 return
//             }
//             print(response?.suggestedFilename ?? url.lastPathComponent)
//             print("Download Finished")
//             DispatchQueue.main.async() {
//                 imgView.image = UIImage(data: data)
//             }
//         }
//     }
    
//     func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//         URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
// >>>>>>> master
//     }
    
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
