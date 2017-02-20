//
//  ViewController.swift
//  memeMe
//
//  Created by Joseph Park on 2/20/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        present(imagePickerController, animated: true, completion: nil)
    }
    

}

