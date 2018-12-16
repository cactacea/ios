//
//  Paginator.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/15.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import RxSwift
import RxCocoa
import Cactacea
import AlamofireImage

class Pager<T> {
    
    typealias fetchBlockType = (_ paginator: Pager<T>, _ first: Bool) -> Observable<[T]>
    typealias completionBlockType = (_ paginator: Pager<T>, _ result: [T]?, _ error: Error?) -> Void
    
    public var items: [T] = []
    public var fetchBlock: fetchBlockType? = nil
    public var completionBlock: completionBlockType? = nil

    private(set) public var connecting = false
    private(set) public var firstFetched = false
    private(set) public var hasNext = false

    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private weak var tableView: UITableView!
    private weak var pageFooterView: PageFooterView?
    
    init(_ tableView: UITableView, _ pageFooterView: PageFooterView? = nil) {
        self.tableView = tableView
        self.pageFooterView = pageFooterView
        self.refreshControl.addTarget(self, action: #selector(Pager.refresh(sender:)), for: .valueChanged)

        pageFooterView?.labelButton?.isHidden = true
        tableView.refreshControl = refreshControl
        tableView.rx.contentOffset.subscribe(onNext: { [weak self] (point) in
            guard let weakSelf = self else { return }
            if point.y + tableView.bounds.size.height > tableView.contentSize.height - tableView.bounds.size.height {
                weakSelf.fetchNext()
            }
        }).disposed(by: disposeBag)
    }
    
    func fetchFirst() {
        fetch(first: true).subscribe().disposed(by: self.disposeBag)
    }
    
    func fetchNext() {
        fetch(first: false).subscribe().disposed(by: self.disposeBag)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        fetch(first: true).subscribe().disposed(by: self.disposeBag)
    }
    
    func fetch(first: Bool) -> Observable<[T]> {
        if connecting {
            return Observable.empty()
        } else if (first == false && self.hasNext == false) {
            return Observable.empty()
        } else if let fetchBlock = self.fetchBlock {
            self.hasNext = false
            self.firstFetched = false
            return fetchBlock(self, first).do(
                onNext: { [weak self] (result) in
                    print("subbscribe")
                    guard let weakSelf = self else { return }
                    if first {
                        weakSelf.items = result
                    } else {
                        weakSelf.items.append(contentsOf: result)
                    }
                    if (result.count < 20) {
                        weakSelf.hasNext = false
                    } else {
                        weakSelf.hasNext = true
                    }
                    
                    weakSelf.firstFetched = true
                    weakSelf.connecting = false
                    
                    if (weakSelf.refreshControl.isRefreshing) {
                        weakSelf.refreshControl.endRefreshing()
                    }
                    weakSelf.tableView.reloadData()

                    if let pageFooterView = weakSelf.pageFooterView {
                        if (weakSelf.items.count == 0) {
                            pageFooterView.labelButton?.isHidden = false
                        } else {
                            pageFooterView.labelButton?.isHidden = true
                        }
                    }
                    
                    if let completionBlock = weakSelf.completionBlock {
                        completionBlock(weakSelf, result, nil)
                    }

                }, onError: { [weak self] (error) in
                    guard let weakSelf = self else { return }
                    if let completionBlock = weakSelf.completionBlock {
                        completionBlock(weakSelf, nil, error)
                    } else {
                        Session.showError(error)
                    }
            })
        } else {
            return Observable.empty()
        }
    }
    

}
