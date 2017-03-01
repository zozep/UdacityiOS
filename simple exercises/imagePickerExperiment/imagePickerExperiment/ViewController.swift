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
        
        let image = UIImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
    
}

