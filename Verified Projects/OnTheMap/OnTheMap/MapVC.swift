//
//  MapVC.swift
//  OnTheMap
//
//  Created by Joseph Park on 4/26/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

    }
    
    //MARK: - Activity Indicator Method
    func showActivityIndicator() -> UIActivityIndicatorView{
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        DispatchQueue.main.async {
            activityIndicator.center = self.view.center
            activityIndicator.color = UIColor.black
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
        return activityIndicator
    }
    
    @IBAction func logout() {
        let activityIndicator = showActivityIndicator()
        UdacityUserAPI.sharedInstance().logout { (result) in
            DispatchQueue.main.async(execute: {
                activityIndicator.hide()
            })
            
            if result {
                DispatchQueue.main.async(execute: {
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.errorInLogout)
            }
        }
        
    }
    
    func getStudentLocations() {
        let activityIndicator = showActivityIndicator()
        UdacityUserAPI.sharedInstance().getStudentLocations(failure: { (error) in
            
            DispatchQueue.main.async(execute: {
                activityIndicator.hide()
                self.createAlertMessage(title: AlertTitle.alert, message: AlertMessage.failedToLoadStudentLocations)
            })
            
        }) { (result) in
            
            print("student locations loaded")
            DispatchQueue.main.async(execute: {
                activityIndicator.hide()
               
                //make func for pins
                print("showing pins WIP")
            })
        }
    }

    
    
}
