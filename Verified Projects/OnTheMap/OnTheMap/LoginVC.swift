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

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapOutKeyboard()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    //Keyboard Notifications
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        self.view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        self.view.frame.origin.y = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        return true
    }
}


extension UIViewController {
    
    //Keyboard Controls
    
    func tapOutKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showSpinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        DispatchQueue.main.async(execute: {
            spinner.center = self.view.center
            spinner.color = UIColor.orange
            self.view.addSubview(spinner)
            spinner.startAnimating()
        })
        
        return spinner
    }
}

