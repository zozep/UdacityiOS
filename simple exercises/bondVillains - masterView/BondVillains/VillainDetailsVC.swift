//
//  VillainDetailsVC.swift
//  BondVillains
//
//  Created by Joseph Park on 3/18/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class VillainDetailsVC: UIViewController {
    
    var villain: Villain!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.label.text = self.villain.name
        self.imageView!.image = UIImage(named: villain.imageName)
    }
}
