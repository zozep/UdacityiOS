//
//  DetailMemeVC.swift
//  memeMe
//
//  Created by Joseph Park on 3/27/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class DetailMemeVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = meme.memedImage
    }
    
    @IBAction func editAction(_ sender: Any) {
        let mainVC = storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        mainVC.memeSentFromMain = self.meme
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
}
