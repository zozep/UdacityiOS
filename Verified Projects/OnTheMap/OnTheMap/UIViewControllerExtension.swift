//
//  UIViewControllerExtension.swift
//  OnTheMap
//
//  Created by Joseph Park on 7/11/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func tapOutKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func createAlertMessage(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async(execute: {
            
            self.present(alert, animated: true, completion: nil)
        })
    }
}

extension UIActivityIndicatorView {
    func hide() {
        DispatchQueue.main.async {
            self.stopAnimating()
            self.removeFromSuperview()
        }
    }
}


