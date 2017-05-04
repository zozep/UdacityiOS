//
//  Indicator.swift
//  OnTheMap
//
//  Created by Joseph Park on 5/4/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class Indicator: UIActivityIndicatorView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    required init(coder aDecoder: NSCoder) {
        fatalError("use init(")
        
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    }
    
    func loadingView(_ isLoading: Bool) {
        if isLoading {
            self.startAnimating()
        } else {
            self.stopAnimating()
            self.hidesWhenStopped = true
        }
    }
    
}
