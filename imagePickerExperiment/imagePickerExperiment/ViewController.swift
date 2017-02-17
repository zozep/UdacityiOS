//
//  ViewController.swift
//  imagePickerExperiment
//
//  Created by Joseph Park on 2/17/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func experiment(_ sender: Any) {
        let controller = UIAlertController()
        controller.title = "Test Alert Title "
        controller.message = "This is a test message"
        
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) { action in self.dismiss(animated: true, completion: nil)
        }
        
        controller.addAction(okAction)
        self.present(controller, animated: true, completion: nil)
    }
    
}

