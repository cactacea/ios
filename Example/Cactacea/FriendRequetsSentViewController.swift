//
//  FriendRequetsSentViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/16.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cactacea
import AlamofireImage

class FriendRequestsSentViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pageFooterView: PageFooterView!
    
    lazy private var pager = Pager<FriendRequest>(tableView, pageFooterView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pager.fetchBlock =  { [weak self] (paginator, first) -> Observable<[FriendRequest]> in
            guard let _ = self else { return Observable.empty() }
            let next = first ? nil : paginator.items.last?.next
            return SessionAPI.findFriendRequests(received: false, since: next, offset: nil, count: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = Session.authentication {
            self.pager.fetchFirst()
        }
    }
    
}

extension FriendRequestsSentViewController: UITableViewDelegate {
}

extension FriendRequestsSentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pager.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? FriendRequestsSentCell  {
            let friendRequest = self.pager.items[indexPath.row]
            cell.friendRequest = friendRequest
        }
        return cell
    }
    
}

