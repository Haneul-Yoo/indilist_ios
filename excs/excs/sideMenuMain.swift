//
//  sideMenuMain.swift
//  excs
//
//  Created by user on 2018. 9. 16..
//  Copyright © 2018년 user. All rights reserved.
//

import UIKit

class sideMenuMain: UIViewController {
    @IBAction func onMoreTapped(){
        print("Toggle Side Menu")
        
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSideMenu201), name: NSNotification.Name("ShowSideMenu201"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSideMenu202), name: NSNotification.Name("ShowSideMenu202"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSideMenu203), name: NSNotification.Name("ShowSideMenu203"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSideMenu204), name: NSNotification.Name("ShowSideMenu204"), object: nil)

    }
    
    @objc func showSideMenu201() {
        performSegue(withIdentifier: "ShowSideMenu201", sender: nil)
    }
    
    @objc func showSideMenu202() {
        performSegue(withIdentifier: "ShowSideMenu202", sender: nil)
    }
    
    @objc func showSideMenu203() {
        performSegue(withIdentifier: "ShowSideMenu203", sender: nil)
    }
    
    @objc func showSideMenu204() {
        performSegue(withIdentifier: "ShowSideMenu204", sender: nil)
    }
}
