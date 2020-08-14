//
//  VKLoginController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 03.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7564962"),
            //URLQueryItem(name: "scope", value: "262150"), 262174
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
        
    }
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }
  
        
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let _ = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        
        Session.shared.token = token
        Session.shared.userId = userIdString
        
        performSegue(withIdentifier: "RunTheAppSegue", sender: nil)
        decisionHandler(.cancel)
    }
}


//import UIKit
//
//class LoginViewController: UIViewController {
//
//    @IBOutlet weak var scrolView: UIScrollView!
//    @IBOutlet private weak var loginField: UITextField!
//    @IBOutlet private weak var passwordField: UITextField!
//
//    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        let tapGesrure: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        scrolView.addGestureRecognizer(tapGesrure)
//    }
//
//    @objc func keyboardWillShow(notification: Notification) {
//        let info = notification.userInfo! as NSDictionary
//        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey)! as! NSValue).cgRectValue.size
//
//        let contectInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
//        scrolView.contentInset = contectInset
//        scrolView.scrollIndicatorInsets = contectInset
//    }
//
//    @objc func keyboardWillHide(notification: Notification) {
//        scrolView.contentInset = UIEdgeInsets.zero
//        scrolView.scrollIndicatorInsets = UIEdgeInsets.zero
//    }
//
//    @objc func hideKeyboard() {
//        scrolView.endEditing(true)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "loginSegue" {
//            guard loginCheck() else {
//                return false
//            }
//
//            fillInCurentUser()
//
//            return true
//        }
//        return false
//    }
//
//    func loginCheck() -> Bool {
//        guard let loginText = loginField.text else { return  false }
//        guard let passwordText = passwordField.text else { return false}
//
//        if loginText == "", passwordText == "" {
//            return true
//        } else {
//            showLoginError()
//            return false
//        }
//    }
//
//    func showLoginError() {
//        let alert = UIAlertController(title: "Ошибка!", message: "Введен неверный логин или пароль", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func fillInCurentUser() {
//        User.curentUser.myGroups =  [
//               Group(groupName: "1"),
//               Group(groupName: "2"),
//               Group(groupName: "3"),
//               Group(groupName: "4"),
//               Group(groupName: "5"),
//               Group(groupName: "6"),
//               Group(groupName: "7"),
//               Group(groupName: "8"),
//               Group(groupName: "9"),
//               Group(groupName: "10")
//           ]
//    }
//}
//
