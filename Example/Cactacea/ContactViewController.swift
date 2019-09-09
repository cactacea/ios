//
//  ContactViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/11/26.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import RxSwift
import RxCocoa
import Cactacea
import AlamofireImage

class ContactViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pageFooterView: PageFooterView!

    lazy private var pager = Pager<User>(tableView, pageFooterView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pager.fetchBlock =  { [weak self] (paginator, first) -> Observable<[User]> in
            guard let _ = self else { return Observable.empty() }
            let next = first ? nil : paginator.items.last?.next
            return SessionAPI.findSessionFriends(since: next, offset: nil, count: nil)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = Session.user {
            self.pager.fetchFirst()
        }
    }

}

extension ContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.pager.items[indexPath.row]
        performSegue(withIdentifier: "chat", sender: user)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chat" {
            if let vc = segue.destination as? ChatViewController, let user = sender as? User {
                vc.user = user
            }
        }
    }
}

extension ContactViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pager.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        if let cell = cell as? ContactCell {
            let user = self.pager.items[indexPath.row]
            cell.user = user
        }
        return cell
    }
    
}

