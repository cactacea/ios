//
//  ReceivedRequestsViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/03.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cactacea
import AlamofireImage

class RequestsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    var items = [FriendRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequests()
    }
    
    func loadRequests() {
        SessionAPI.findFriendRequests(received: true, since: nil, offset: nil, count: nil) { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else if let result = result {
                weakSelf.items.append(contentsOf: result)
                weakSelf.tableView.reloadData()
            }
        }
    }
    
}

extension RequestsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? RequestsCell  {
            let friendRequest = items[indexPath.row]
            cell.friendRequest = friendRequest
        }
        return cell
    }
    
}

