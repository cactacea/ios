//
//  NotificationSettingsViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/16.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import Cactacea

class NotificationSettingsViewController: UITableViewController {

    enum Section: Int {
        case feed = 0
        case comment = 1
        case friendRequest = 2
        case message = 3
        case groupMessage = 4
        case groupInvitation = 5
        case showMessage = 6
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SettingsAPI.findPushNotification() { [weak self] (result, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
            } else if let result = result {
                weakSelf.feed = result.feed
                weakSelf.comment = result.comment
                weakSelf.friendRequest = result.friendRequest
                weakSelf.message = result.message
                weakSelf.channelMessage = result.channelMessage
                weakSelf.invitation = result.invitation
                weakSelf.showMessage = result.showMessage
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value: Bool = indexPath.row == 1
        if indexPath.section == Section.feed.rawValue {
            self.feed = value
        } else if indexPath.section == Section.comment.rawValue {
            self.comment = value
        } else if indexPath.section == Section.friendRequest.rawValue {
            self.friendRequest = value
        } else if indexPath.section == Section.message.rawValue {
            self.message = value
        } else if indexPath.section == Section.groupMessage.rawValue {
            self.channelMessage = value
        } else if indexPath.section == Section.groupInvitation.rawValue {
            self.invitation = value
        } else if indexPath.section == Section.showMessage.rawValue {
            self.showMessage = value
        }
        
        let body = PutNotificationSettingBody(
            feed: self.feed,
            comment: self.comment,
            friendRequest: self.friendRequest,
            message: self.message,
            channelMessage: self.channelMessage,
            invitation: self.invitation,
            showMessage: self.showMessage)
        
        SettingsAPI.updatePushNotification(body: body) { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                Session.showError(error)
                if indexPath.section == Section.feed.rawValue {
                    weakSelf.feed = !value
                } else if indexPath.section == Section.comment.rawValue {
                    weakSelf.comment = !value
                } else if indexPath.section == Section.friendRequest.rawValue {
                    weakSelf.friendRequest = !value
                } else if indexPath.section == Section.message.rawValue {
                    weakSelf.message = !value
                } else if indexPath.section == Section.groupMessage.rawValue {
                    weakSelf.channelMessage = !value
                } else if indexPath.section == Section.groupInvitation.rawValue {
                    weakSelf.invitation = !value
                } else if indexPath.section == Section.showMessage.rawValue {
                    weakSelf.showMessage = !value
                }
            }
        }

    }
    
    var feed: Bool = false {
        willSet {
            if newValue {
                feedOffCell?.accessoryType = .none
                feedOnCell?.accessoryType = .checkmark
            } else {
                feedOffCell?.accessoryType = .checkmark
                feedOnCell?.accessoryType = .none
            }
        }
    }

    var comment: Bool = false {
        willSet {
            if newValue {
                commentOffCell?.accessoryType = .none
                commentOnCell?.accessoryType = .checkmark
            } else {
                commentOffCell?.accessoryType = .checkmark
                commentOnCell?.accessoryType = .none
            }
        }
    }

    var friendRequest: Bool = false {
        willSet {
            if newValue {
                friendRequestOffCell?.accessoryType = .none
                friendRequestOnCell?.accessoryType = .checkmark
            } else {
                friendRequestOffCell?.accessoryType = .checkmark
                friendRequestOnCell?.accessoryType = .none
            }
        }
    }
    
    var message: Bool = false {
        willSet {
            if newValue {
                messageOffCell?.accessoryType = .none
                messageOnCell?.accessoryType = .checkmark
            } else {
                messageOffCell?.accessoryType = .checkmark
                messageOnCell?.accessoryType = .none
            }
        }
    }
    
    var channelMessage: Bool = false {
        willSet {
            if newValue {
                groupMessageOffCell?.accessoryType = .none
                groupMessageOnCell?.accessoryType = .checkmark
            } else {
                groupMessageOffCell?.accessoryType = .checkmark
                groupMessageOnCell?.accessoryType = .none
            }
        }
    }
    
    var invitation: Bool = false {
        willSet {
            if newValue {
                groupInvitationOffCell?.accessoryType = .none
                groupInvitationOnCell?.accessoryType = .checkmark
            } else {
                groupInvitationOffCell?.accessoryType = .checkmark
                groupInvitationOnCell?.accessoryType = .none
            }
        }
    }
    
    var showMessage: Bool = false {
        willSet {
            if newValue {
                showMessageOffCell?.accessoryType = .none
                showMessageOnCell?.accessoryType = .checkmark
            } else {
                showMessageOffCell?.accessoryType = .checkmark
                showMessageOnCell?.accessoryType = .none
            }
        }
    }
    
    private var feedOffCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 0, section: Section.feed.rawValue))
    }
    
    private var feedOnCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 1, section: Section.feed.rawValue))
    }

    private var commentOffCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 0, section: Section.comment.rawValue))
    }
    
    private var commentOnCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 1, section: Section.comment.rawValue))
    }

    private var friendRequestOffCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 0, section: Section.friendRequest.rawValue))
    }
    
    private var friendRequestOnCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 1, section: Section.friendRequest.rawValue))
    }

    private var messageOffCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 0, section: Section.message.rawValue))
    }
    
    private var messageOnCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 1, section: Section.message.rawValue))
    }

    private var groupMessageOffCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 0, section: Section.groupMessage.rawValue))
    }
    
    private var groupMessageOnCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 1, section: Section.groupMessage.rawValue))
    }

    private var groupInvitationOffCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 0, section: Section.groupInvitation.rawValue))
    }
    
    private var groupInvitationOnCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 1, section: Section.groupInvitation.rawValue))
    }

    private var showMessageOffCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 0, section: Section.showMessage.rawValue))
    }
    
    private var showMessageOnCell: UITableViewCell? {
        return self.tableView.cellForRow(at: IndexPath(row: 1, section: Section.showMessage.rawValue))
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
