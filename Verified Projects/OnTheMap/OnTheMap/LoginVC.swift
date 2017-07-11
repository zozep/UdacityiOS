//
//  LoginVC.swift
//  OnTheMap
//
//  Created by Joseph Park on 5/1/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    //Login Info
    
    var appDelegate: AppDelegate!
    var indicator = Indicator()
    var selectedTextField: UITextField!
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapOutKeyboard()
        subscribeToKeyboardNotifications()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        userNameField.text = ""
        passwordField.text = ""
        
    }
    
    // MARK: - KeyBoard Resigning and Notification
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField
    }
    
    func subscribeToKeyboardNotifications() {
        userNameField.delegate = self
        passwordField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //keyboard
    func keyboardWillShow(_ notification: Notification) {
        if passwordField.isFirstResponder && view.frame.origin.y == 0 {
            view.frame.origin.y = getKeyboardHeight(notification) * -0.5
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if selectedTextField.isFirstResponder {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let userName = userNameField.text, let password = passwordField.text else {
            return
        }
        
        if userName.isEmpty || password.isEmpty {
            self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.enterValidCredentials)
            return
        }
        
        let activityIndicator = showActivityIndicator()
        
        UdacityUserAPI.sharedInstance().signInWithUdacityCredentials(userName: userName, password: password) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode < 200 || response.statusCode > 300 {
                    activityIndicator.hide()
                    self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.invalidCredentials)
                    
                    return
                }
            }
            
            if let error = error {
                activityIndicator.hide()
                
                //no internet
                if error.code == NSURLErrorNotConnectedToInternet {
                    self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.noInternetConnection)
                    return
                    
                } else {
                    self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.failedRequest)
                }
                
            } else {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with:data!, options:.allowFragments) as? [String:AnyObject]
                    
                    if let account = jsonData?["account"] as? [String:AnyObject] {
                        
                        // store unique key
                        Users.sharedInstance.uniqueKey = account["uniqueKey"] as? String
                        
                        // fetch user infromation
                        UdacityUserAPI.sharedInstance().getUserLocationData { (result, error) in
                            activityIndicator.hide()
                            
                            if result {
                                // on success
                                DispatchQueue.main.async(execute: {
                                    self.performSegue(withIdentifier: "loginToTabView", sender: self)
                                })
                            } else {
                                // failure to fetch user information.
                                self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.failedToFetchUserDetails)
                            }
                        }
                        
                    } else {
                        activityIndicator.hide()
                        self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.invalidCredentials)
                        
                        return
                    }
                } catch {
                    activityIndicator.hide()
                    self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.failedRequest)
                }
            }
        }
    }

    @IBAction func signUpButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: URLString.signUp)!, options: [:], completionHandler:  nil)
    }

    //MARK: Activity Indicator Method
    func showActivityIndicator() -> UIActivityIndicatorView {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        DispatchQueue.main.async {
            activityIndicator.center = self.view.center
            activityIndicator.color = UIColor.black
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
        return activityIndicator
    }

}
