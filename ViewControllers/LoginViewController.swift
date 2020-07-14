//
//  LoginViewController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 03.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet private weak var loginField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesrure: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrolView.addGestureRecognizer(tapGesrure)
    }

    @objc func keyboardWillShow(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey)! as! NSValue).cgRectValue.size
        
        let contectInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        scrolView.contentInset = contectInset
        scrolView.scrollIndicatorInsets = contectInset
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrolView.contentInset = UIEdgeInsets.zero
        scrolView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func hideKeyboard() {
        scrolView.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            guard loginCheck() else {
                return false
            }
            
            fillInCurentUser()
            
            return true
        }
        return false
    }
    
    func loginCheck() -> Bool {
        guard let loginText = loginField.text else { return  false }
        guard let passwordText = passwordField.text else { return false}
        
        if loginText == "", passwordText == "" {
            return true
        } else {
            showLoginError()
            return false
        }
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Ошибка!", message: "Введен неверный логин или пароль", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    func fillInCurentUser() {
        User.curentUser.myGroups =  [
               Group(groupName: "1"),
               Group(groupName: "2"),
               Group(groupName: "3"),
               Group(groupName: "4"),
               Group(groupName: "5"),
               Group(groupName: "6"),
               Group(groupName: "7"),
               Group(groupName: "8"),
               Group(groupName: "9"),
               Group(groupName: "10")
           ]
    }
}
