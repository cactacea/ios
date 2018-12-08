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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        incrementalText
            .flatMap { [weak self] text -> Driver<[Account]> in
                guard let _ = self else { return .just([]) }
                if text.isEmpty {
                    return .just([])
                }
                let accountName: String? = text
                let observable = AccountsAPI.findAccounts(accountName: accountName, since: nil, offset: nil, count: nil)
                return observable.asDriver(onErrorJustReturn: [])
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    private let disposeBag = DisposeBag()
    private let dataSource = DataSource()
    
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



extension FindFriendsViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function)
    }
}

extension FindFriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}

final class DataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {
    
    typealias  Element = [Account]
    
    private var items: Element = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? FindFriendsCell  {
            let account = items[indexPath.row]
            cell.accountNameLabel.text = account.accountName
            if let smallImageURL = account.profileImageUrl {
                let urlRequest = Session.request(url: smallImageURL)
                cell.profileImageView.af_setImage(withURLRequest: urlRequest)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        Binder(self) { (dataSource, items) in
//            if dataSource.items == items { return }
            dataSource.items = items
            tableView.reloadData()
            }
            .on(observedEvent)
    }
}
