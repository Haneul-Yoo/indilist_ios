//
//  sideMenu.swift
//  excs
//
//  Created by user on 2018. 9. 16..
//  Copyright © 2018년 user. All rights reserved.
//

import UIKit

class sideMenu: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        switch(indexPath.row){
        case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowSideMenu201"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowSideMenu202"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("ShowSideMenu203"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("ShowSideMenu204"), object: nil)
        default: break
        }
    }

}
