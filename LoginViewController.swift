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
            return loginCheck()
        }
        return false
    }
    
    
    func loginCheck() -> Bool {
        guard let loginText = loginField.text else { return  false }
        guard let passwordText = passwordField.text else { return false}
        
        if loginText == "admin", passwordText == "12345" {
            return true
        } else {
            return false
        }
    }
}

