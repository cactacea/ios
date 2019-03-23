//
// GroupsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class GroupsAPI {
    /**
     Create a group
     
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createGroup(body: PostGroupBody, completion: @escaping ((_ data: GroupCreated?,_ error: Error?) -> Void)) {
        createGroupWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Create a group
     
     - parameter body: (body)  
     - returns: Observable<GroupCreated>
     */
    open class func createGroup(body: PostGroupBody) -> Observable<GroupCreated> {
        return Observable.create { observer -> Disposable in
            createGroup(body: body) { data, error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Create a group
     - POST /groups
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example={
  "id" : 0.80082819046101150206595775671303272247314453125
}}]
     
     - parameter body: (body)  

     - returns: RequestBuilder<GroupCreated> 
     */
    open class func createGroupWithRequestBuilder(body: PostGroupBody) -> RequestBuilder<GroupCreated> {
        let path = "/groups"
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<GroupCreated>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Hide a group and delete all messages
     
     - parameter id: (path) Group identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteGroup(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteGroupWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Hide a group and delete all messages
     
     - parameter id: (path) Group identifier. 
     - returns: Observable<Void>
     */
    open class func deleteGroup(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            deleteGroup(id: id) { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Hide a group and delete all messages
     - DELETE /groups/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Group identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteGroupWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/groups/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get basic information about a group
     
     - parameter id: (path) Group identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findGroup(id: Int64, completion: @escaping ((_ data: Group?,_ error: Error?) -> Void)) {
        findGroupWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get basic information about a group
     
     - parameter id: (path) Group identifier. 
     - returns: Observable<Group>
     */
    open class func findGroup(id: Int64) -> Observable<Group> {
        return Observable.create { observer -> Disposable in
            findGroup(id: id) { data, error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Get basic information about a group
     - GET /groups/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example={
  "next" : 4.1456080298839363962315474054776132106781005859375,
  "lastPostedAt" : 3.61607674925191080461672754609026014804840087890625,
  "accountCount" : 9,
  "name" : "name",
  "invitationOnly" : true,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : {
    "next" : 7.061401241503109105224211816675961017608642578125,
    "accountCount" : 5,
    "unread" : true,
    "groupId" : 1.46581298050294517310021547018550336360931396484375,
    "medium" : {
      "contentWarning" : true,
      "size" : 5,
      "contentDeleted" : true,
      "width" : 1,
      "mediumType" : "image",
      "id" : 6.02745618307040320615897144307382404804229736328125,
      "uri" : "uri",
      "height" : 5,
      "thumbnailUrl" : "thumbnailUrl"
    },
    "message" : "message",
    "contentWarning" : true,
    "readAccountCount" : 5,
    "messageType" : "text",
    "postedAt" : 2,
    "contentDeleted" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "account" : {
      "birthday" : 2.3021358869347654518833223846741020679473876953125,
      "next" : 9.301444243932575517419536481611430644989013671875,
      "friendCount" : 5,
      "accountName" : "accountName",
      "displayName" : "displayName",
      "joinedAt" : 7.061401241503109105224211816675961017608642578125,
      "feedCount" : 5,
      "bio" : "bio",
      "followingCount" : 6,
      "friendRequestInProgress" : true,
      "muting" : true,
      "web" : "web",
      "blocking" : true,
      "following" : true,
      "isFriend" : true,
      "location" : "location",
      "id" : 0.80082819046101150206595775671303272247314453125,
      "isFollower" : true,
      "profileImageUrl" : "profileImageUrl",
      "followerCount" : 1
    }
  },
  "authorityType" : "owner",
  "organizedAt" : 2,
  "privacyType" : "everyone"
}}]
     
     - parameter id: (path) Group identifier. 

     - returns: RequestBuilder<Group> 
     */
    open class func findGroupWithRequestBuilder(id: Int64) -> RequestBuilder<Group> {
        var path = "/groups/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Group>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get accounts list of a group
     
     - parameter id: (path) Group identifier. 
     - parameter since: (query) Filters accounts which started on since or later. (optional)
     - parameter offset: (query) The offset of accounts. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of accounts returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func findGroupAccounts(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Group]?,_ error: Error?) -> Void)) {
        findGroupAccountsWithRequestBuilder(id: id, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Get accounts list of a group
     
     - parameter id: (path) Group identifier. 
     - parameter since: (query) Filters accounts which started on since or later. (optional)
     - parameter offset: (query) The offset of accounts. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of accounts returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Group]>
     */
    open class func findGroupAccounts(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Group]> {
        return Observable.create { observer -> Disposable in
            findGroupAccounts(id: id, since: since, offset: offset, count: count) { data, error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Get accounts list of a group
     - GET /groups/{id}/accounts
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example=[ {
  "next" : 4.1456080298839363962315474054776132106781005859375,
  "lastPostedAt" : 3.61607674925191080461672754609026014804840087890625,
  "accountCount" : 9,
  "name" : "name",
  "invitationOnly" : true,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : {
    "next" : 7.061401241503109105224211816675961017608642578125,
    "accountCount" : 5,
    "unread" : true,
    "groupId" : 1.46581298050294517310021547018550336360931396484375,
    "medium" : {
      "contentWarning" : true,
      "size" : 5,
      "contentDeleted" : true,
      "width" : 1,
      "mediumType" : "image",
      "id" : 6.02745618307040320615897144307382404804229736328125,
      "uri" : "uri",
      "height" : 5,
      "thumbnailUrl" : "thumbnailUrl"
    },
    "message" : "message",
    "contentWarning" : true,
    "readAccountCount" : 5,
    "messageType" : "text",
    "postedAt" : 2,
    "contentDeleted" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "account" : {
      "birthday" : 2.3021358869347654518833223846741020679473876953125,
      "next" : 9.301444243932575517419536481611430644989013671875,
      "friendCount" : 5,
      "accountName" : "accountName",
      "displayName" : "displayName",
      "joinedAt" : 7.061401241503109105224211816675961017608642578125,
      "feedCount" : 5,
      "bio" : "bio",
      "followingCount" : 6,
      "friendRequestInProgress" : true,
      "muting" : true,
      "web" : "web",
      "blocking" : true,
      "following" : true,
      "isFriend" : true,
      "location" : "location",
      "id" : 0.80082819046101150206595775671303272247314453125,
      "isFollower" : true,
      "profileImageUrl" : "profileImageUrl",
      "followerCount" : 1
    }
  },
  "authorityType" : "owner",
  "organizedAt" : 2,
  "privacyType" : "everyone"
}, {
  "next" : 4.1456080298839363962315474054776132106781005859375,
  "lastPostedAt" : 3.61607674925191080461672754609026014804840087890625,
  "accountCount" : 9,
  "name" : "name",
  "invitationOnly" : true,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : {
    "next" : 7.061401241503109105224211816675961017608642578125,
    "accountCount" : 5,
    "unread" : true,
    "groupId" : 1.46581298050294517310021547018550336360931396484375,
    "medium" : {
      "contentWarning" : true,
      "size" : 5,
      "contentDeleted" : true,
      "width" : 1,
      "mediumType" : "image",
      "id" : 6.02745618307040320615897144307382404804229736328125,
      "uri" : "uri",
      "height" : 5,
      "thumbnailUrl" : "thumbnailUrl"
    },
    "message" : "message",
    "contentWarning" : true,
    "readAccountCount" : 5,
    "messageType" : "text",
    "postedAt" : 2,
    "contentDeleted" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "account" : {
      "birthday" : 2.3021358869347654518833223846741020679473876953125,
      "next" : 9.301444243932575517419536481611430644989013671875,
      "friendCount" : 5,
      "accountName" : "accountName",
      "displayName" : "displayName",
      "joinedAt" : 7.061401241503109105224211816675961017608642578125,
      "feedCount" : 5,
      "bio" : "bio",
      "followingCount" : 6,
      "friendRequestInProgress" : true,
      "muting" : true,
      "web" : "web",
      "blocking" : true,
      "following" : true,
      "isFriend" : true,
      "location" : "location",
      "id" : 0.80082819046101150206595775671303272247314453125,
      "isFollower" : true,
      "profileImageUrl" : "profileImageUrl",
      "followerCount" : 1
    }
  },
  "authorityType" : "owner",
  "organizedAt" : 2,
  "privacyType" : "everyone"
} ]}]
     
     - parameter id: (path) Group identifier. 
     - parameter since: (query) Filters accounts which started on since or later. (optional)
     - parameter offset: (query) The offset of accounts. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of accounts returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<[Group]> 
     */
    open class func findGroupAccountsWithRequestBuilder(id: Int64, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Group]> {
        var path = "/groups/{id}/accounts"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "since": since, 
            "offset": offset, 
            "count": count
        ])
        

        let requestBuilder: RequestBuilder<[Group]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Hide a group
     
     - parameter id: (path) Group identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func hideGroup(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        hideGroupWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Hide a group
     
     - parameter id: (path) Group identifier. 
     - returns: Observable<Void>
     */
    open class func hideGroup(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            hideGroup(id: id) { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Hide a group
     - POST /groups/{id}/hides
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Group identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func hideGroupWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/groups/{id}/hides"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Join to a group,
     
     - parameter id: (path) Group identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func joinGroup(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        joinGroupWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Join to a group,
     
     - parameter id: (path) Group identifier. 
     - returns: Observable<Void>
     */
    open class func joinGroup(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            joinGroup(id: id) { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Join to a group,
     - POST /groups/{id}/join
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Group identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func joinGroupWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/groups/{id}/join"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Leave from a group
     
     - parameter id: (path) Group groupInvitation identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func leaveGroup(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        leaveGroupWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Leave from a group
     
     - parameter id: (path) Group groupInvitation identifier. 
     - returns: Observable<Void>
     */
    open class func leaveGroup(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            leaveGroup(id: id) { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Leave from a group
     - POST /groups/{id}/leave
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Group groupInvitation identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func leaveGroupWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/groups/{id}/leave"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Report a group
     
     - parameter id: (path) Group identifier. 
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func reportGroup(id: Int64, body: PostGroupReportBody, completion: @escaping ((_ error: Error?) -> Void)) {
        reportGroupWithRequestBuilder(id: id, body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Report a group
     
     - parameter id: (path) Group identifier. 
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func reportGroup(id: Int64, body: PostGroupReportBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            reportGroup(id: id, body: body) { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Report a group
     - POST /groups/{id}/reports
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Group identifier. 
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func reportGroupWithRequestBuilder(id: Int64, body: PostGroupReportBody) -> RequestBuilder<Void> {
        var path = "/groups/{id}/reports"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     * enum for parameter groupPrivacyType
     */
    public enum GroupPrivacyType_searchGroups: String { 
        case everyone = "everyone"
        case following = "following"
        case followers = "followers"
        case friends = "friends"
    }

    /**
     Search groups
     
     - parameter groupName: (query) Filters groups which group name start of. (optional)
     - parameter invitationOnly: (query) Filters groups that invited accounts can join in. (optional)
     - parameter groupPrivacyType: (query) Filters groups which can join in. (optional)
     - parameter since: (query) Filters groups which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of groups returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func searchGroups(groupName: String? = nil, invitationOnly: Int64? = nil, groupPrivacyType: GroupPrivacyType_searchGroups? = nil, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil, completion: @escaping ((_ data: [Group]?,_ error: Error?) -> Void)) {
        searchGroupsWithRequestBuilder(groupName: groupName, invitationOnly: invitationOnly, groupPrivacyType: groupPrivacyType, since: since, offset: offset, count: count).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Search groups
     
     - parameter groupName: (query) Filters groups which group name start of. (optional)
     - parameter invitationOnly: (query) Filters groups that invited accounts can join in. (optional)
     - parameter groupPrivacyType: (query) Filters groups which can join in. (optional)
     - parameter since: (query) Filters groups which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of groups returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)
     - returns: Observable<[Group]>
     */
    open class func searchGroups(groupName: String? = nil, invitationOnly: Int64? = nil, groupPrivacyType: GroupPrivacyType_searchGroups? = nil, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> Observable<[Group]> {
        return Observable.create { observer -> Disposable in
            searchGroups(groupName: groupName, invitationOnly: invitationOnly, groupPrivacyType: groupPrivacyType, since: since, offset: offset, count: count) { data, error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Search groups
     - GET /groups
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     - examples: [{contentType=application/json, example=[ {
  "next" : 4.1456080298839363962315474054776132106781005859375,
  "lastPostedAt" : 3.61607674925191080461672754609026014804840087890625,
  "accountCount" : 9,
  "name" : "name",
  "invitationOnly" : true,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : {
    "next" : 7.061401241503109105224211816675961017608642578125,
    "accountCount" : 5,
    "unread" : true,
    "groupId" : 1.46581298050294517310021547018550336360931396484375,
    "medium" : {
      "contentWarning" : true,
      "size" : 5,
      "contentDeleted" : true,
      "width" : 1,
      "mediumType" : "image",
      "id" : 6.02745618307040320615897144307382404804229736328125,
      "uri" : "uri",
      "height" : 5,
      "thumbnailUrl" : "thumbnailUrl"
    },
    "message" : "message",
    "contentWarning" : true,
    "readAccountCount" : 5,
    "messageType" : "text",
    "postedAt" : 2,
    "contentDeleted" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "account" : {
      "birthday" : 2.3021358869347654518833223846741020679473876953125,
      "next" : 9.301444243932575517419536481611430644989013671875,
      "friendCount" : 5,
      "accountName" : "accountName",
      "displayName" : "displayName",
      "joinedAt" : 7.061401241503109105224211816675961017608642578125,
      "feedCount" : 5,
      "bio" : "bio",
      "followingCount" : 6,
      "friendRequestInProgress" : true,
      "muting" : true,
      "web" : "web",
      "blocking" : true,
      "following" : true,
      "isFriend" : true,
      "location" : "location",
      "id" : 0.80082819046101150206595775671303272247314453125,
      "isFollower" : true,
      "profileImageUrl" : "profileImageUrl",
      "followerCount" : 1
    }
  },
  "authorityType" : "owner",
  "organizedAt" : 2,
  "privacyType" : "everyone"
}, {
  "next" : 4.1456080298839363962315474054776132106781005859375,
  "lastPostedAt" : 3.61607674925191080461672754609026014804840087890625,
  "accountCount" : 9,
  "name" : "name",
  "invitationOnly" : true,
  "id" : 0.80082819046101150206595775671303272247314453125,
  "message" : {
    "next" : 7.061401241503109105224211816675961017608642578125,
    "accountCount" : 5,
    "unread" : true,
    "groupId" : 1.46581298050294517310021547018550336360931396484375,
    "medium" : {
      "contentWarning" : true,
      "size" : 5,
      "contentDeleted" : true,
      "width" : 1,
      "mediumType" : "image",
      "id" : 6.02745618307040320615897144307382404804229736328125,
      "uri" : "uri",
      "height" : 5,
      "thumbnailUrl" : "thumbnailUrl"
    },
    "message" : "message",
    "contentWarning" : true,
    "readAccountCount" : 5,
    "messageType" : "text",
    "postedAt" : 2,
    "contentDeleted" : true,
    "id" : 6.02745618307040320615897144307382404804229736328125,
    "account" : {
      "birthday" : 2.3021358869347654518833223846741020679473876953125,
      "next" : 9.301444243932575517419536481611430644989013671875,
      "friendCount" : 5,
      "accountName" : "accountName",
      "displayName" : "displayName",
      "joinedAt" : 7.061401241503109105224211816675961017608642578125,
      "feedCount" : 5,
      "bio" : "bio",
      "followingCount" : 6,
      "friendRequestInProgress" : true,
      "muting" : true,
      "web" : "web",
      "blocking" : true,
      "following" : true,
      "isFriend" : true,
      "location" : "location",
      "id" : 0.80082819046101150206595775671303272247314453125,
      "isFollower" : true,
      "profileImageUrl" : "profileImageUrl",
      "followerCount" : 1
    }
  },
  "authorityType" : "owner",
  "organizedAt" : 2,
  "privacyType" : "everyone"
} ]}]
     
     - parameter groupName: (query) Filters groups which group name start of. (optional)
     - parameter invitationOnly: (query) Filters groups that invited accounts can join in. (optional)
     - parameter groupPrivacyType: (query) Filters groups which can join in. (optional)
     - parameter since: (query) Filters groups which started on since or later. (optional)
     - parameter offset: (query) The offset of messages. By default the value is 0. (optional)
     - parameter count: (query) Maximum number of groups returned on one result page. By default the value is 20 entries. The page size can never be larger than 50. (optional)

     - returns: RequestBuilder<[Group]> 
     */
    open class func searchGroupsWithRequestBuilder(groupName: String? = nil, invitationOnly: Int64? = nil, groupPrivacyType: GroupPrivacyType_searchGroups? = nil, since: Int64? = nil, offset: Int64? = nil, count: Int64? = nil) -> RequestBuilder<[Group]> {
        let path = "/groups"
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "groupName": groupName, 
            "invitationOnly": invitationOnly, 
            "groupPrivacyType": groupPrivacyType?.rawValue, 
            "since": since, 
            "offset": offset, 
            "count": count
        ])
        

        let requestBuilder: RequestBuilder<[Group]>.Type = CactaceaAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Show a group
     
     - parameter id: (path) Group identifier. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func showGroup(id: Int64, completion: @escaping ((_ error: Error?) -> Void)) {
        showGroupWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Show a group
     
     - parameter id: (path) Group identifier. 
     - returns: Observable<Void>
     */
    open class func showGroup(id: Int64) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            showGroup(id: id) { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Show a group
     - DELETE /groups/{id}/hides
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Group identifier. 

     - returns: RequestBuilder<Void> 
     */
    open class func showGroupWithRequestBuilder(id: Int64) -> RequestBuilder<Void> {
        var path = "/groups/{id}/hides"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Update a group
     
     - parameter id: (path) Group identifier. 
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateGroup(id: Int64, body: PutGroupBody, completion: @escaping ((_ error: Error?) -> Void)) {
        updateGroupWithRequestBuilder(id: id, body: body).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**
     Update a group
     
     - parameter id: (path) Group identifier. 
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func updateGroup(id: Int64, body: PutGroupBody) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            updateGroup(id: id, body: body) { error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(()))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Update a group
     - PUT /groups/{id}
     - API Key:
       - type: apiKey X-API-KEY 
       - name: api_key
     - OAuth:
       - type: oauth2
       - name: cactacea_auth
     
     - parameter id: (path) Group identifier. 
     - parameter body: (body)  

     - returns: RequestBuilder<Void> 
     */
    open class func updateGroupWithRequestBuilder(id: Int64, body: PutGroupBody) -> RequestBuilder<Void> {
        var path = "/groups/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = CactaceaAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CactaceaAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
