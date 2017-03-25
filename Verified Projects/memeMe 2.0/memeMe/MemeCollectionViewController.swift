//
//  MemeCollectionViewController.swift
//  memeMe
//
//  Created by Joseph Park on 3/20/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class MemeCollectionVivewController: UIViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.meme
    }
}
