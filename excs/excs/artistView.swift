//
//  artistView.swift
//  excs
//
//  Created by user on 2018. 9. 17..
//  Copyright © 2018년 user. All rights reserved.
//

import UIKit

class artistView: UIViewController {
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!

    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sideMenuOpen = false
        sideMenuConstraint.constant = -272
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
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
}
