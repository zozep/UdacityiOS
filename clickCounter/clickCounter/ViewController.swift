//
//  ViewController.swift
//  clickCounter
//
//  Created by Joseph Park on 2/17/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count: Int = 0
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func incrementCount() {
        self.count += 1
        self.label.text = "\(self.count)"

    }
    
    @IBAction func decrementCount() {
        self.count -= 1
        self.label.text = "\(self.count)"

    }

}

