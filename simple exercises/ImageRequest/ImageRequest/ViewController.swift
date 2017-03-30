//
//  ViewController.swift
//  ImageRequest
//
//  Created by Jarrod Parkes on 11/3/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURL = URL(string: "http://www.puppiesden.com/pics/1/poodle-puppy2.jpg")
        
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
        
            if error == nil {
                let downloadedImage = UIImage(data: data!)
                
                performUIUpdatesOnMain {
                    self.imageView.image = downloadedImage
                }
            }
        }
        task.resume()
    }
}
