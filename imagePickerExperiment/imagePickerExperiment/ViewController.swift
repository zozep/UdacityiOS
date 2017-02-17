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
    
    @IBAction func experiment() {
        let nextController = UIImagePickerController()
        self.present(nextController, animated: true, completion: nil)
        
    }

}

