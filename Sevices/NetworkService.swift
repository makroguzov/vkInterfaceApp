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
            
            //let users = response.map { UserModel(json: $0 as! [String: Any]) }
            //closure(users)
        }
    }

    func loadUserGroupInvitations(offset: Int, count: Int, extended: Int, complitoin: @escaping (UserGroupInvitationModel) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.getInvites"
    
        let params: Parameters = [
            "access_token": Session.shared.token,
            "extended": extended,
            "offset" : offset,
            "count" : count,
            "v": "5.92"
        ]
    
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseDecodable { (response: DataResponse<UserGroupInvitationModel, AFError>) in
            switch response.result {
                case .success(let userGroupInvitationModel):
                    complitoin(userGroupInvitationModel)
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }

//        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
//            guard let json = response.value else { return }
//            print(json)
//        }
    }

    
    func loadUserGroups(userId: String, extended: Int, filter: String, fields: String, offset: Int, count: Int,
     complitoin: @escaping (UserGroupsModel) -> Void) {
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

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseDecodable { (response: DataResponse<UserGroupsModel, AFError>) in
            switch response.result {
            case .success(let userGroupModel):
                complitoin(userGroupModel)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    func loadUserFriends(user_id: String, order: String, list_id: String, count: Int, offset: Int, fields: String, name_case: String, ref: String, complition: @escaping (UserFriendsModel) -> Void) {
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

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseDecodable() {
            (response: DataResponse<UserFriendsModel, AFError>) in
            
            switch response.result {
            case .success(let userFriendsModel):
                complition(userFriendsModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
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

