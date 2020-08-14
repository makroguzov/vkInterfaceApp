//
//  NetworkService.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 11.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    static var shared = NetworkService()
    private init() {}

    
    static let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    func loadGroups(userId: String, extended: Int, filter: String, fields: String, offset: Int, count: Int,
                    closure: @escaping ([GroupModel], Int) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "user_id" : userId,
            "extended": extended,
            "filter" : filter,
            "fields" : fields,
            "offset" : offset,
            "count" : count,
            "v": "5.92"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            let  response = (json as! [String: Any])["response"] as! [String: Any]
            
            let totalCount = response["count"] as! Int
            let groups = (response["items"] as! [[String: Any]]).map{GroupModel(json: $0)}
            

            closure(groups, totalCount)
        }
    }
    
    func loadGroupsInvitations(offset: Int, count: Int, extended: Int, closure: @escaping ([GroupInvitationModel]) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.getInvites"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "extended": extended,
            "offset" : offset,
            "count" : count,
            "v": "5.92"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            let response = (json as! [String: Any])["response"] as! [String: Any]
 
            let ivents: [GroupInvitationModel] = (response["items"] as! [Any]).map{ GroupInvitationModel(json: $0 as! [String: Any]) }

            
            let groups: [Int: [GroupModel]] = Dictionary(grouping: (response["groups"] as! [Any]).map{ GroupModel(json: $0 as! [String: Any]) }){ $0.id }
            let usersId: [String] = [Int](Dictionary(grouping: (response["profiles"] as! [Any]).map{ $0 as! [String: Any] }){ $0["id"] as! Int }.keys).map{ String($0) }
                
            
            self.loadUserInfo(user_ids: usersId.joined(separator: ",") , fields: "photo_200", name_case: "") { usersArray in
                let users = Dictionary(grouping: usersArray) { $0.id }
                var preparedInvitations = [GroupInvitationModel]()
   
                for ivent in ivents {
                    var preparedIvent = ivent
                    
                    if let invitor = groups[abs(ivent.invited_by)] {
                        preparedIvent.invitor = GroupInvitationModel.Invitor(group: invitor[0])
                    } else if let invitor = users[ivent.invited_by] {
                        preparedIvent.invitor = GroupInvitationModel.Invitor(user: invitor[0])
                    }
                    
                    preparedInvitations.append(preparedIvent)
                }
                
                closure(preparedInvitations)
            }
        }
    }
    
    func loadUserInfo(user_ids: String, fields: String, name_case: String, closure: @escaping ([UserModel]) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/users.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "user_ids": user_ids,
            "fields": fields,
            "name_case" : name_case,
            "v": "5.92"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            let  response = (json as! [String: Any])["response"] as! [Any]
            
            let users = response.map { UserModel(json: $0 as! [String: Any]) }
            closure(users)
        }
    }

    func loadUserFriends(user_id: String, order: String, list_id: String, count: Int, offset: Int, fields: String, name_case: String, ref: String, compition: @escaping ([UserModel], Int) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "user_id": user_id,
            "order": order,
            "list_id": list_id,
            "count": count,
            "offset": offset,
            "fields": fields,
            "name_case": name_case,
            "ref": ref,
            "v": "5.92"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            let  response = (json as! [String: Any])["response"] as! [String: Any]

            let friendsAmount = response["count"] as! Int
            let users = (response["items"] as! [Any]).map { UserModel(json: $0 as! [String: Any]) }
            compition(users, friendsAmount)
        }
    }
}





//    func simpleWeatherRequest() {
//         //München
//        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Tomsk&appid=72d0c294c9e0f3370139ce5d00a6b575&units=metric") else { return }
//
//        let session = URLSession.shared
//
//        print(Thread.current)
//
//        let dataTask = session.dataTask(with: url) { (data, response, error) in
//            if let data = data {
//                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
//                    print(json)
//                }
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//            print(Thread.current)
//        }
//        dataTask.resume()
//    }
//
//    func advancedWeatherRequest() {
//        // Custom session
//        let configuration = URLSessionConfiguration.default
//        let session =  URLSession(configuration: configuration)
//
//        var urlConstructor = URLComponents()
//        urlConstructor.scheme = "http"
//        urlConstructor.host = "api.openweathermap.org"
//        urlConstructor.path = "/data/2.5/weather"
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "q", value: "Tomsk"),
//            URLQueryItem(name: "appid", value: "72d0c294c9e0f3370139ce5d00a6b575"),
//            URLQueryItem(name: "units", value: "metric"),
//        ]
//
//        guard let url = urlConstructor.url else { return }
//
//        let dataTask = session.dataTask(with: url) { (data, response, error) in
//            if let data = data {
//                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
//                    print(json)
//                }
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//        dataTask.resume()
//    }
//
//    func postTemplateRequest() {
//        let configuration = URLSessionConfiguration.default
//        let session =  URLSession(configuration: configuration)
//
//        var urlConstructor = URLComponents()
//        urlConstructor.scheme = "http"
//        urlConstructor.host = "jsonplaceholder.typicode.com"
//        urlConstructor.path = "/posts"
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "title", value: "foo"),
//            URLQueryItem(name: "body", value: "bar"),
//            URLQueryItem(name: "userId", value: "1")
//        ]
//
//        guard let url = urlConstructor.url else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allowsCellularAccess = false
//
//        let dataTask = session.dataTask(with: request) { (data, response, error) in
//            if let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) {
//                print(json)
//            }
//        }
//        dataTask.resume()
//    }
//
//    func alamofireRequest() {
//        AF.request("http://api.openweathermap.org/data/2.5/weather?q=Tomsk&appid=72d0c294c9e0f3370139ce5d00a6b575&units=metric").responseJSON { response in
//            if let data = response.value {
//                print(data)
//            }
//        }
//    }
//
//    func alamofireAdvancedRequest() {
//        let url = "http://api.openweathermap.org"
//        let path = "/data/2.5/weather"
//        let params = [
//            "q": "Tomsk",
//            "appid": "72d0c294c9e0f3370139ce5d00a6b575",
//            "units": "metric",
//        ]
//
//        AF.request(url + path, method: .get, parameters: params).responseJSON { response in
//            if let data = response.value {
//                print(data)
//            }
//        }
//
//        NetworkService.session.request(url + path, method: .get, parameters: params).response { response in
//            switch response.result {
//            case .success(let data):
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) {
//                    print(json)
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
