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
    var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //label
        let label = UILabel()
        label.frame = CGRect.init(x: 150, y: 150, width: 60, height: 60)
        label.text = "0"
        self.view.addSubview(label)
        self.label = label
        
        //button
        let incrementButton = UIButton()
        incrementButton.frame = CGRect.init(x: 50, y: 50, width: 50, height: 50)
        incrementButton.setTitle("increment", for: .normal)
        incrementButton.setTitleColor(UIColor.cyan, for: .normal)
        self.view.addSubview(incrementButton)
        incrementButton.addTarget(self, action: #selector(ViewController.incrementCount), for: UIControlEvents.touchUpInside)
        
        let decrementButton = UIButton()
        decrementButton.frame = CGRect.init(x: 50, y: 150, width: 50, height: 50)
        decrementButton.setTitle("decrement", for: .normal)
        decrementButton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(decrementButton)
        decrementButton.addTarget(self, action: #selector(ViewController.decrementCount), for: UIControlEvents.touchUpInside)

        
    }
    func incrementCount() {
        self.count += 1
        self.label.text = "\(self.count)"
        self.view.backgroundColor = UIColor.blue

    }
    
    func decrementCount() {
        self.count -= 1
        self.label.text = "\(self.count)"
        self.view.backgroundColor = UIColor.darkGray

    }

}

