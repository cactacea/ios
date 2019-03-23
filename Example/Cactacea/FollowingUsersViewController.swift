//
//  FollowingUsersViewControlller.swift
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

class FollowingUsersViewControlller: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pageFooterView: PageFooterView!
    
    lazy private var pager = Pager<Account>(tableView, pageFooterView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pager.fetchBlock =  { [weak self] (paginator, first) -> Observable<[Account]> in
            guard let _ = self else { return Observable.empty() }
            let next = first ? nil : paginator.items.last?.next
            return SessionAPI.findSessionFollowing(since: next, offset: nil, count: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = Session.authentication {
            self.pager.fetchFirst()
        }
    }
    
}

extension FollowingUsersViewControlller: UITableViewDelegate {
}

extension FollowingUsersViewControlller: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pager.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? FollowingUserCell {
            let account = self.pager.items[indexPath.row]
            cell.account = account
        }
        return cell
    }
    
}

