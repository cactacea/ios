//
//  ActivityViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/12.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit

class ActivityViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        if let _ = Session.authentication {
            self.tableView.tableHeaderView = nil
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
