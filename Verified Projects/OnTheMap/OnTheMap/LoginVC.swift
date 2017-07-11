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
    
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
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
    
    //keyboard
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        return true
    }

    
    
    
    
    
    
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: URLString.signUp)!, options: [:], completionHandler:  nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        dismissKeyboard()
        self.view.endEditing(true)
        loginWithUdacity()
        indicator.loadingView(true)
    }
    
    func loginWithUdacity() {

        guard let email = userNameField.text, let password = passwordField.text else {
            print("error on email or text")
            return
        }
        
        if email.isEmpty || password.isEmpty {
            self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.enterValidCredentials)
            return
        }
        
        _ = showActivityIndicator()
        UdacityUserAPI.sharedInstance().signInWithUdacityCredentials(userName: userNameField, password: passwordField, completionHandler: <#T##RequestCompletionHandler?##RequestCompletionHandler?##(Data?, URLResponse?, NSError?) -> Void#>)
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
    
    //MARK: Activity Indicator Method
    func showActivityIndicator() -> UIActivityIndicatorView{
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        DispatchQueue.main.async {
            activityIndicator.center = self.view.center
            activityIndicator.color = UIColor.black
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
        return activityIndicator
    }
    
    func createAlertMessage(title:String,message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async(execute: {
            
            self.present(alert, animated: true, completion: nil)
        })
    }

}

