//
//  FindFriendsViewController.swift
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

class FindFriendsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var pageFooterView: PageFooterView!

    private let disposeBag = DisposeBag()

    lazy private var pager = Pager<Account>(tableView, pageFooterView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pager.fetchBlock =  { [weak self] (paginator, first) -> Observable<[Account]> in
            guard let weakSelf = self else { return Observable.empty() }
            let accountName = weakSelf.searchBar.text
            let next = first ? nil : paginator.items.last?.next
            return SessionAPI.findAccounts(accountName: accountName,
                                            since: next,
                                            offset: nil,
                                            count: nil)
        }
        
        self.pager.fetchFirst()

        self.incrementalText.asObservable().flatMap(fetch).subscribe().disposed(by: self.disposeBag)

    }
    
}

extension FindFriendsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }

    private func fetch(accountName: String?) -> Observable<[Account]> {
        return self.pager.fetch(first: true)
    }
    
    private var incrementalText: Driver<String> {
        return rx
            .methodInvoked(#selector(UISearchBarDelegate.searchBar(_:shouldChangeTextIn:replacementText:)))
            .debounce(0.2, scheduler: MainScheduler.instance)
            .flatMap { [weak self] _ -> Observable<String> in .just(self?.searchBar.text ?? "") }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
    }

}

extension FindFriendsViewController: UITableViewDelegate {
}

extension FindFriendsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? FindFriendsCell  {
            let account = self.pager.items[indexPath.row]
            cell.account = account
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pager.items.count
    }

}
