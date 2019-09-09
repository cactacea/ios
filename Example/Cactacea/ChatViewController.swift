//
//  ChatViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/23.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import MessageKit
//import MessageInputBar
import Cactacea
import SwiftDate
import MapKit
import Starscream



extension ChatViewController: WebSocketDelegate {

    func websocketDidConnect(socket: WebSocketClient) {
//        print("websocket is connected:")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
//        print("websocket is disconnected: \(error?.localizedDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        if let session = Session.user {
            do {
                let chatMessage = try JSONDecoder().decode(ChatMessage.self, from: text.data(using: .utf8)!)
                if let message = chatMessage.message, session.id != message.user.id {
                    insertMessage(message)
                }
            } catch let error {
                print(error)
            }
        }
        print("got some text: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
//        print("got some data: \(data.count)")
    }
    
    func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
//        print("Got pong! Maybe some data: \(data?.count)")
    }
    
}

class ChatViewController: MessagesViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let socket = WebSocket(url: URL(string: "ws://10.0.1.3:14000")!)
    
    var user: User?
    var channel: Channel?
    
    var messageList: [Message] = []
    
    let refreshControl = UIRefreshControl()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.delegate = self
        socket.connect()
        
        if let accessToken = Session.accessToken {
            self.sendCommand(name: "connect", value: accessToken)
        }

//        if UserDefaults.isFirstLaunch() {
//            // Enable Text Messages
//            UserDefaults.standard.set(true, forKey: "Text Messages")
//        }
        
        if let user = user {
            self.title = user.displayName
            
            UsersAPI.findUserChannel(id: user.id) { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let result = result {
                    weakSelf.channel = result
                    weakSelf.loadFirstMessages()
                    weakSelf.sendCommand(name: "join", value: String(result.id))
                } else if let error = error {
                    Session.showError(error)
                }
            }
        }

        configureMessageCollectionView()
        configureMessageInputBar()
        loadFirstMessages()
//        title = "MessageKit"
    }
    
    func sendCommand(name: String, value: String) {
        let parameters = ["name": name, "value": value]
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
            self.socket.write(string: jsonString)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        MockSocket.shared.connect(with: [SampleData.shared.steven, SampleData.shared.wu])
//            .onNewMessage { [weak self] message in
//                self?.insertMessage(message)
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        MockSocket.shared.disconnect()
    }
    
    func loadFirstMessages() {
        if let group = channel {
            MessagesAPI.findMessages(id: group.id, ascending: true, since: nil, offset: nil, count: 20) { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let messages = result {
                    weakSelf.messageList = messages
                    weakSelf.messagesCollectionView.reloadData()
                    weakSelf.messagesCollectionView.scrollToBottom()
                } else if let error = error {
                    Session.showError(error)
                }
            }
        }
    }
    
    @objc
    func loadMoreMessages() {
        if let group = channel {
            MessagesAPI.findMessages(id: group.id, ascending: false, since: self.messageList.first?.id, offset: nil, count: 20) { [weak self] (result, error) in
                guard let weakSelf = self else { return }
                if let messages = result {
                    if messages.count == 0 {
                        weakSelf.messagesCollectionView.reloadData()
                        weakSelf.refreshControl.endRefreshing()
                    } else {
                        weakSelf.messagesCollectionView.reloadDataAndKeepOffset()
                        weakSelf.refreshControl.endRefreshing()
                    }
                } else if let error = error {
                    Session.showError(error)
                }
            }
        }
    }
    
    func configureMessageCollectionView() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        
        scrollsToBottomOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        
        messagesCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)

        //
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self

    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .mainBlue
        messageInputBar.sendButton.tintColor = .mainBlue
    }
    
    // MARK: - Helpers
    
    func insertMessage(_ message: Message) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    

}

extension ChatViewController: MessagesDataSource {

    // MARK: - MessagesDataSource

    func currentSender() -> SenderType {
        if let user = Session.user {
            return Sender(id: String(user.id), displayName: user.displayName)
        }
        fatalError("Session not found")
    }

    func isFromCurrentSender(message: MessageType) -> Bool {
        return message.sender.senderId == currentSender().senderId
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        let message = messageList[indexPath.section]
        return message
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return nil
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
//    func customCell(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell {
//        fatalError(MessageKitError.customDataUnresolvedCell)
//    }
    
    func typingIndicator(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell {
        return messagesCollectionView.dequeueReusableCell(TypingIndicatorCell.self, for: indexPath)
    }

    
}

// MARK: - MessageCellDelegate

extension ChatViewController: MessageCellDelegate {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("Message tapped")
    }
    
    func didTapCellTopLabel(in cell: MessageCollectionViewCell) {
        print("Top cell label tapped")
    }
    
    func didTapMessageTopLabel(in cell: MessageCollectionViewCell) {
        print("Top message label tapped")
    }
    
    func didTapMessageBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
        print("Accessory view tapped")
    }
    
}

// MARK: - MessageLabelDelegate

extension ChatViewController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String: String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
        print("URL Selected: \(url)")
    }
    
    func didSelectTransitInformation(_ transitInformation: [String: String]) {
        print("TransitInformation Selected: \(transitInformation)")
    }
    
}

// MARK: - MessageInputBarDelegate

extension ChatViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        if let channel = channel {
            for component in inputBar.inputTextView.components {
                
                if let str = component as? String {
                    let body = PostTextBody(channelId: channel.id, message: str)
                    MessagesAPI.postText(body: body) { [weak self] (result, error) in
                        guard let weakSelf = self else { return }
                        if let result = result {
                            weakSelf.insertMessage(result)
                        } else if let error = error {
                            Session.showError(error)
                        }
                    }
//                } else if let img = component as? UIImage {
                }
                
            }
        }
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
}


extension ChatViewController: MessagesDisplayDelegate {
    
    // MARK: - Text Messages
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
        return MessageLabel.defaultAttributes
    }
    
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date, .transitInformation]
    }
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .mainBlue : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let avatar = Avatar(image: nil, initials: "")
        avatarView.set(avatar: avatar)
    }
    
    // MARK: - Location Messages
    
    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
        let pinImage = #imageLiteral(resourceName: "ic_map_marker")
        annotationView.image = pinImage
        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
        return annotationView
    }
    
    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)? {
        return { view in
            view.layer.transform = CATransform3DMakeScale(2, 2, 2)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
                view.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    func snapshotOptionsForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LocationMessageSnapshotOptions {
        
        return LocationMessageSnapshotOptions(showsBuildings: true, showsPointsOfInterest: true, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    }
    
}

// MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 18
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
}
